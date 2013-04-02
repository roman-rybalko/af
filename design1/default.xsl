<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!--
	
	WebKit's XSLTProcessor does not support xsl:include
	see https://code.google.com/p/chromium/issues/detail?id=8441
	Chrome issue 8441
	
	That's why keeping everything in a single file.
	 
	 -->

	<xsl:output method="html" doctype-system="about:legacy-compat"/>
	
	<!--
	
	Menu 
	
	 -->

	<xsl:template match="topmenu">
		<ul class="nav pull-right">
			<xsl:apply-templates select="item"/>
		</ul>
	</xsl:template>

	<xsl:template match="menu">
		<ul class="nav">
			<xsl:apply-templates select="item"/>
		</ul>
	</xsl:template>

	<xsl:template match="menu/item[@link] | topmenu/item[@link]">
		<li>
			<a href="{@link}">
				<xsl:apply-templates select="logo"/>
				<xsl:value-of select="text"/>
			</a>
		</li>
	</xsl:template>

	<xsl:template match="menu/item[@selected] | topmenu/item[@selected]">
		<li class="active">
			<a href="#">
				<xsl:apply-templates select="logo"/>
				<xsl:value-of select="text"/>
			</a>
		</li>
	</xsl:template>

	<xsl:template match="item/logo[@type='login']">
		<i class="icon-lock"/>
	</xsl:template>

	<xsl:template match="item/logo[@type='signup']">
		<i class="icon-edit"/>
	</xsl:template>

	<xsl:template match="item/logo[@type='description']">
		<i class="icon-list-alt"/>
	</xsl:template>

	<xsl:template match="item/logo[@type='benefits']">
		<i class="icon-ok"/>
	</xsl:template>

	<xsl:template match="item/logo[@type='price']">
		<i class="icon-tags"/>
	</xsl:template>

	<xsl:template match="item/logo[@type='people']">
		<i class="icon-user"/>
	</xsl:template>

	<xsl:template match="item/logo[@type='gear']">
		<i class="icon-cog"/>
	</xsl:template>

	<!--
	
	Form
	
	-->

	<xsl:variable name="form_common">
		<div class="hide">
			<div class="af-title">
				<xsl:apply-templates select="document('msg.xml')//info/hidden"/>
			</div>
			<div id="error_http" class="alert alert-block alert-error">
				<h4 class="alert-headeing">
					<xsl:apply-templates select="document('msg.xml')//error/http"/>
				</h4>
				<span id="error_http_descr"/>
			</div>
			<div id="error_init_http" class="alert alert-block alert-error">
				<h4 class="alert-headeing">
					<xsl:apply-templates select="document('msg.xml')//error/init_http"/>
				</h4>
				<span id="error_init_http_descr"/>
			</div>
			<div id="error_init_xslt" class="alert alert-block alert-error">
				<h4 class="alert-headeing">
					<xsl:apply-templates select="document('msg.xml')//error/init_xslt"/>
				</h4>
				<span id="error_init_xslt_descr"/>
			</div>
			<div id="error_xslt" class="alert alert-block alert-error">
				<h4 class="alert-headeing">
					<xsl:apply-templates select="document('msg.xml')//error/xslt"/>
				</h4>
				<span id="error_xslt_descr"/>
			</div>
			<xsl:variable name="info_loading_text">
				<xsl:apply-templates select="document('msg.xml')//info/loading"/>
			</xsl:variable>
			<img src="design1/preloader2.gif" id="info_loading" alt="{$info_loading_text}"/>
		</div>

		<script type="text/javascript" src="design1/sarissa.js"/>
		<script type="text/javascript" src="design1/jquery.debug.js"/>
		<script type="text/javascript" src="design1/utils.js"/>
		<script type="text/javascript">
			function rebindForms()
			{
				$("form").unbind("submit").submit(function() {
					var form = this;
					var result = "#" + $(form).attr("id") + "result";
					$(result).empty().append($("#info_loading").clone());
					$(form).find("button.af-submit").attr("disabled", "disabled");
					$.get($(form).attr("action"), $(form).serialize()).done(function(data) {
						var html = xsltproc.transformToFragment(data, document);
						if (html) $(result).empty().append(html);
						else $(result).empty().append($("#error_xslt").clone())
							.find("#error_xlst_descr").empty().append("xsltproc.transformToFragment failed");
						rebindForms();
					}).fail(function(req, status, error) {
						$(result).empty().append($("#error_http").clone())
							.find("#error_http_descr").empty().append("status: " + strescape(status) + ", error: " + strescape(error));
						rebindForms();
					});
					return false;
				});
				$("button.af-submit").removeAttr("disabled");
			}

			var xsltproc;
			$(document).ready(function() {
				xsltproc = new XSLTProcessor();
				$.get("design1/default.xsl").done(function(data) {
					var error = false;
					try {
						xsltproc.importStylesheet(data);
						if (! xsltproc.transformToFragment(str2xml("<cgi/>"), document))
							error = "xsltproc.transformToFragment failed";
					} catch (e) {
						error = obj2str(e);
					}
					if (error) {
						$("#result_global").empty().append($("#error_init_xslt").clone())
							.find("#error_init_xslt_descr").empty().append(error);
						return;
					}
					rebindForms();
				}).fail(function(req, status, error) {
					$("#result_global").empty().append($("#error_init_http").clone())
						.find("#error_init_http_descr").empty().append("status: " + strescape(status) + ", error: " + strescape(error));
				});
			});
		</script>
	</xsl:variable>
	
	<xsl:template match="form">
		<xsl:variable name="id" select="generate-id()"/>
		<form action="{@link}" id="{$id}" class="form-horizontal">
			<xsl:apply-templates select="input"/>
		</form>
		<div id="{$id}result"/>
	</xsl:template>
	
	<xsl:template match="input[@type='text' or @type='password']">
		<xsl:variable name="id" select="generate-id()"/>
		<div class="control-group">
			<label class="control-label" for="{$id}"><xsl:value-of select="title"/></label>
			<div class="controls">
				<input name="{@name}" type="{@type}" id="{$id}" placeholder="{text}"/>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="input[@type='submit']">
		<div class="control-group">
			<div class="controls">
				<button type="submit" class="af-submit btn btn-primary" disabled="1">
					<xsl:apply-templates select="title"/>
				</button>
			</div>
		</div>
	</xsl:template>

	<!--
	
	Content
	 
	 -->

	<xsl:template match="content">
		<div class="row">
			<div class="span12">
				<xsl:apply-templates select="title"/>
				<xsl:apply-templates select="image"/>
				<xsl:apply-templates select="section"/>
				<xsl:apply-templates select="table"/>
				<xsl:apply-templates select="form"/>
				<xsl:apply-templates select="redirect"/>
				<xsl:apply-templates select="content"/>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="content/content">
		<div class="row-fluid">
			<div class="span12">
				<xsl:apply-templates select="title"/>
				<xsl:apply-templates select="image"/>
				<xsl:apply-templates select="section"/>
				<xsl:apply-templates select="table"/>
				<xsl:apply-templates select="form"/>
				<xsl:apply-templates select="redirect"/>
				<xsl:apply-templates select="content"/>
			</div>
		</div>
	</xsl:template>


	<xsl:template match="content/title">
		<div class="af-title">
			<xsl:apply-templates select="text"/>
		</div>
	</xsl:template>

	<xsl:template match="content/title[@link]">
		<img src="{@link}"/>
	</xsl:template>


	<xsl:template match="image">
		<img src="{@link}" class="af-image-centered"/>
	</xsl:template>

	<xsl:variable name="image_common">
		<script type="text/javascript">
			function reformatImages()
			{
				$(".af-image-floated").each(function() {
					if ($(this).width() / $(this).parent().width() &gt; 0.6) {
						$(this).removeClass("af-image-floated");
						$(this).addClass("af-image-centered");
					}
				});
				$(".af-image-centered").each(function() {
					if ($(this).width() / $(this).parent().width() &lt;= 0.6) {
						$(this).removeClass("af-image-centered");
						$(this).addClass("af-image-floated");
					}
				});
			}

			$(window).load(reformatImages);
			$(window).resize(reformatImages);
		</script>
	</xsl:variable>


	<xsl:template match="table">
		<table class="table table-hover">
			<xsl:if test="head">
				<thead>
					<xsl:apply-templates select="head"/>
				</thead>
			</xsl:if>
			<xsl:if test="row">
				<tbody>
					<xsl:apply-templates select="row"/>
				</tbody>
			</xsl:if>
		</table>
	</xsl:template>

	<xsl:template match="table/head | table/row">
		<tr>
			<xsl:apply-templates select="cell"/>
		</tr>
	</xsl:template>

	<xsl:template match="table/head/cell">
		<th>
			<xsl:apply-templates select="text"/>
		</th>
	</xsl:template>
	
	<xsl:template match="table/row/cell">
		<td>
			<xsl:apply-templates select="text"/>
		</td>
	</xsl:template>


	<xsl:template match="redirect">
		<div class="af-redirect">
			<a href="{@link}" class="btn btn-large btn-success">
				<xsl:apply-templates select="text"/>
			</a>
		</div>
		<xsl:if test="@force">
			<script type="text/javascript">
				document.location = "<xsl:value-of select="@link"/>";
			</script>
		</xsl:if>
	</xsl:template>

	
	<xsl:template match="section">
		<p class="af-section">
			<xsl:apply-templates select="text"/>
		</p>
	</xsl:template>

	<xsl:template match="text">
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="text[@id]">
		<xsl:variable name="id" select="@id"/>
		<xsl:value-of select="document('../locale.xml')/locale/text[@id=$id]"/>
	</xsl:template>
	
	<!--
	
	Stup
	 
	 -->

	<xsl:template match="locale">
		<html></html>
	</xsl:template>

	<xsl:template match="error">
		<html></html>
	</xsl:template>

	<!--
	
	Static
	 
	 -->

	<xsl:template match="static">
		<html>
			<head>
				<xsl:apply-templates select="title"/>
				<link href="design1/bootstrap.css" rel="stylesheet"/>
				<link href="design1/bootstrap-responsive.css" rel="stylesheet"/>
				<link href="design1/af.css" rel="stylesheet"/>
			</head>
			<body>
				<div id="af-page">
					<div id="af-header">
						<div class="container">
							<xsl:apply-templates select="logo"/>
						</div>
					</div>
					<div class="container">
						<div class="navbar">
							<div class="navbar-inner">
								<xsl:apply-templates select="menu"/>
								<xsl:apply-templates select="topmenu"/>
							</div>
						</div>
						<div class="row">
							<div id="result_global" class="span12"/>
						</div>
						<xsl:apply-templates select="content"/>
					</div>
					<div id="af-page-push"/>
				</div>
				<div id="af-footer">
					<div class="container">
						<p class="muted af-footer-line-1">
							<xsl:apply-templates select="document('msg.xml')//other/footer_1"/>
						</p>
						<p class="muted af-footer-line-2">
							<xsl:apply-templates select="document('msg.xml')//other/footer_2"/>
						</p>
					</div>
				</div>
				<script type="text/javascript" src="design1/jquery.js"/>
				<script type="text/javascript" src="design1/bootstrap.js"/>
				<xsl:if test="//form">
					<xsl:copy-of select="$form_common"/>
				</xsl:if>
				<xsl:if test="//image">
					<xsl:copy-of select="$image_common"/>
				</xsl:if>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="static/title">
		<title>
			<xsl:apply-templates select="text"/>
		</title>
	</xsl:template>

	<xsl:template match="static/logo">
		<h1>
			<xsl:apply-templates select="document('msg.xml')//other/logo"/>
		</h1>
		<p class="lead">
			<xsl:apply-templates select="document('msg.xml')//other/logo_descr"/>
		</p>
	</xsl:template>

	<!--
	
	CGI
	 
	 -->

	<xsl:template match="cgi">
		<xsl:apply-templates select="content"/>
	</xsl:template>
	
</xsl:stylesheet>