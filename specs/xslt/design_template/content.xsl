<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="content">
		<div class="row">
			<div class="span12">
				<h2>
					<xsl:apply-templates select="title"/>
				</h2>
				<xsl:apply-templates select="image"/>
				<xsl:apply-templates select="text"/>
				<xsl:apply-templates select="content"/>
				<xsl:apply-templates select="redirect"/>
				<xsl:apply-templates select="form"/>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="content/content">
		<div class="row-fluid">
			<div class="span12">
				<xsl:apply-templates select="image"/>
				<h3>
					<xsl:apply-templates select="title"/>
				</h3>
				<xsl:apply-templates select="text"/>
				<xsl:apply-templates select="content"/>
				<xsl:apply-templates select="redirect"/>
				<xsl:apply-templates select="form"/>
			</div>
		</div>
	</xsl:template>


	<xsl:template match="title">
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="title[@link]">
		<img src="{@link}"/>
	</xsl:template>

	<xsl:template match="title[@id]">
		<xsl:variable name="id" select="@id"/>
		<xsl:value-of select="document('../locale.xml')/locale/text[@id=$id]"/>
	</xsl:template>


	<xsl:template match="image">
		<img src="{@link}" align="left"/>
	</xsl:template>

	<xsl:template match="image[@type='dia1']">
		<img src="design_template/af1.jpg" align="left"/>
	</xsl:template>

	<xsl:template match="image[@type='dia2']">
		<img src="design_template/af2.jpg" align="left"/>
	</xsl:template>


	<xsl:template match="redirect">
		<a href="{@link}" class="btn btn-large btn-success">
			<xsl:value-of select="."/>
		</a>
		<xsl:if test="@force">
			<script type="text/javascript">
				document.location = "<xsl:value-of select="@link"/>";
			</script>
		</xsl:if>
	</xsl:template>


	<xsl:template match="text">
		<xsl:value-of select="."/>
		<br/>
		<br/>
	</xsl:template>

	<xsl:template match="text[@id]">
		<xsl:variable name="id" select="@id"/>
		<xsl:value-of select="document('../locale.xml')/locale/text[@id=$id]"/>
		<br/>
		<br/>
	</xsl:template>
	
</xsl:stylesheet>