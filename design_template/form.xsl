<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="form_common">
		<div style="display:none">
			<div id="error_http" style="background-color:red">
				<xsl:apply-templates select="document('error.xml')//error/http"/>
			</div>
		</div>

		<script src="design_template/sarissa-compressed.js"/>
		<script src="design_template/sarissa_ieemu_xpath-compressed.js"/>
		<script src="design_template/jquery.min.js"/>
		
		<script>
			var xsltproc = new XSLTProcessor();
			var xsltdoc = Sarissa.getDomDocument("default.xsl");
			xsltproc.importStylesheet(xsltdoc);
			
			function formHandler(form, link, result)
			{
				$(form).submit(function() {
					$.get(link, $(form).serialize()).done(function(data) {
						alert(data);
						alert(xsltdoc);
						var newdata = xsltproc.transformToDocument(data);
						alert(newdata);
						$(result).empty().append(newdata).show();
					}).fail(function() {
						$(result).empty().append($("#error_http")).show();
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
				<input type="submit" value="{$label}"/>
			</td>
		</tr>
	</xsl:template>

</xsl:stylesheet>