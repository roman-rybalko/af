<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="form_common">
		<div style="display:none">
			<div id="error_http" style="background-color:red">
				<xsl:apply-templates select="document('msg.xml')//error/http"/>
				<br/>
				<span id="error_http_descr"></span>
			</div>
			<div id="error_init_http" style="background-color:red">
				<xsl:apply-templates select="document('msg.xml')//error/init_http"/>
				<br/>
				<span id="error_init_http_descr"></span>
			</div>
			<div id="error_init_xslt" style="background-color:red">
				<xsl:apply-templates select="document('msg.xml')//error/init_xsl"/>
				<br/>
				<span id="error_init_xslt_descr"></span>
			</div>
			<div id="info_loading">
				<xsl:apply-templates select="document('msg.xml')//info/loading"/>
			</div>
		</div>
		<div id="result_global"></div>

		<script type="text/javascript" src="design_template/sarissa-compressed.js"/>
		<script type="text/javascript" src="design_template/jquery.min.js"/>
		<script type="text/javascript" src="design_template/jquery.debug.js"/>
		<script type="text/javascript" src="design_template/utils.js"/>
		<script type="text/javascript">
			var xsltproc;
			$(document).ready(function() {
				xsltproc = new XSLTProcessor();
				$.log("xsltproc: " + xsltproc);
				$.get("default.xsl").done(function(data) {
					try {
						$.log("call xsltproc.importStylesheet");
						xsltproc.importStylesheet(data);
					} catch (e) {
						$.log("call xsltproc.importStylesheet error");
						$.log("e: " + e);
						$("#result_global").empty().append($("#error_init_xslt")).show();
						$("#error_init_xslt_descr").empty().append(obj2str(e));
						return;
					}
					$("input[type='submit']").removeAttr("disabled");
					$.log("init done");
				}).fail(function(req, status, error) {
					$.log("init http error");
					$.log("req: " + req);
					$.log("status: " + status);
					$.log("error: " + error);
					$("#result_global").empty().append($("#error_init_http")).show();
					$("#error_init_http_descr").empty().append("status: " + status + ", error: " + obj2str(error));
				});
			});
			function formHandler(form, link, result)
			{
				$(form).submit(function() {
					$.log("submit: " + form);
					$(form).find("input[type='submit']").attr("disabled","disabled");
					$(result).empty().append($("#info_loading")).show();
					$.get(link, $(form).serialize()).done(function(data) {
						$.log("result: " + xml2str(data));
						$(result).empty().append(xsltproc.transformToFragment(data, document)).show().fadeOut(3000);
						$(form).find("input[type='submit']").removeAttr("disabled");
					}).fail(function(req, status, error) {
						$.log("error");
						$.log("req: " + req);
						$.log("status: " + status);
						$.log("error: " + error);
						$(result).empty().append($("#error_http")).show().fadeOut(5000);
						$("#error_http_descr").empty().append("status: " + status + ", error: " + obj2str(error));
						$(form).find("input[type='submit']").removeAttr("disabled");
					});
					return false;
				});
			}
		</script>
	</xsl:variable>
	
	<xsl:template match="form">
		<xsl:variable name="id" select="generate-id()"/>
		<form id="form{$id}">
			<table>
			<xsl:apply-templates select="input"/>
			</table>
		</form>
		<div id="result{$id}"/>
		<script>
			formHandler("#form<xsl:value-of select="$id"/>", "<xsl:value-of select="@link"/>", "#result<xsl:value-of select="$id"/>");
		</script>
	</xsl:template>
	
	<xsl:template match="input[@type='text']">
		<tr>
			<td>
				<xsl:apply-templates select="text"/>
			</td>
			<td>
				<input type="text" name="{@name}"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="input[@type='password']">
		<tr>
			<td>
				<xsl:apply-templates select="text"/>
			</td>
			<td>
				<input type="password" name="{@name}"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="input[@type='submit']">
		<tr>
			<td>
			</td>
			<td>
				<xsl:variable name="label">
					<xsl:apply-templates select="text"/>
				</xsl:variable>
				<input type="submit" value="{$label}" disabled="disabled"/>
			</td>
		</tr>
	</xsl:template>

</xsl:stylesheet>