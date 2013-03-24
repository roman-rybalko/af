<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="form_common">
		<div style="display:none">
			<div id="error_http" class="alert alert-block alert-error fade in">
				<h4 class="alert-headeing">
					<xsl:apply-templates select="document('msg.xml')//error/http"/>
				</h4>
				<span id="error_http_descr"/>
			</div>
			<div id="error_init_http" class="alert alert-block alert-error fade in">
				<h4 class="alert-headeing">
					<xsl:apply-templates select="document('msg.xml')//error/init_http"/>
				</h4>
				<span id="error_init_http_descr"/>
			</div>
			<div id="error_init_xslt" style="background-color:red">
				<h4 class="alert-headeing">
					<xsl:apply-templates select="document('msg.xml')//error/init_xsl"/>
				</h4>
				<span id="error_init_xslt_descr"/>
			</div>
			<img src="design_template/preloader2.gif" id="info_loading"/>
		</div>

		<script type="text/javascript" src="design_template/sarissa.js"/>
		<script type="text/javascript" src="design_template/jquery.debug.js"/>
		<script type="text/javascript" src="design_template/utils.js"/>
		<script type="text/javascript">
			function rebindForms()
			{
				$("form").unbind("submit").submit(function() {
					var form = this;
					var result = "#" + $(form).attr("id") + "result";
					$(result).empty().append($("#info_loading"));
					$(form).find("button.af-submit").attr("disabled", "disabled");
					$.get($(form).attr("action"), $(form).serialize()).done(function(data) {
						$(result).empty().append(xsltproc.transformToFragment(data, document));
						rebindForms();
					}).fail(function(req, status, error) {
						$(result).empty().append($("#error_http"));
						$("#error_http_descr").empty().append("status: " + status + ", error: " + error);
						rebindForms();
					});
					return false;
				});
				$("button.af-submit").removeAttr("disabled");
			}

			var xsltproc;
			$(document).ready(function() {
				xsltproc = new XSLTProcessor();
				$.get("default.xsl").done(function(data) {
					try {
						xsltproc.importStylesheet(data);
					} catch (e) {
						$(".result_global").empty().append($("#error_init_xslt"));
						$("#error_init_xslt_descr").empty().append(obj2str(e));
						return;
					}
					rebindForms();
				}).fail(function(req, status, error) {
					$(".result_global").empty().append($("#error_init_http"));
					$("#error_init_http_descr").empty().append("status: " + status + ", error: " + error);
				});
			});
		</script>
	</xsl:variable>
	
	<xsl:template match="form">
		<xsl:variable name="id" select="generate-id()"/>
		<form action="{@link}" id="{$id}" class="form-horizontal">
			<legend><xsl:value-of select="title"/></legend>
			<xsl:apply-templates select="input"/>
		</form>
		<div class="row-fluid">
			<div class="span12" id="{$id}result"/>
		</div>
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

</xsl:stylesheet>