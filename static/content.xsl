<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="content">
		<tr><td>
		<xsl:apply-templates select="title"/>
		<p>
		<xsl:apply-templates select="image"/>
		<xsl:apply-templates select="text"/>
		<xsl:apply-templates select="section"/>
		<xsl:apply-templates select="link"/>
		</p>
		</td></tr>
	</xsl:template>

	<xsl:template match="title">
		<span style="background-color:#d7e6fb;">
			<xsl:value-of select="."/>
		</span>
	</xsl:template>

	<xsl:template match="title[@link]">
		<xsl:if test="@link">
			<img src="{@link}" align="left"/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="title[@id]">
		<xsl:variable name="id" select="@id"/>
		<xsl:value-of select="document('../locale.xml')/locale/text[@id=$id]"/>
	</xsl:template>

	<xsl:template match="image">
		<img src="{@link}" align="left"/>
	</xsl:template>

	<xsl:template match="link">
		<a href="{@link}">
			<xsl:value-of select="."/>
		</a>
	</xsl:template>

	<xsl:template match="text">
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="text[@id]">
		<xsl:variable name="id" select="@id"/>
		<xsl:value-of select="document('../locale.xml')/locale/text[@id=$id]"/>
	</xsl:template>

	<xsl:template match="section">
		<table>
		<tr>
			<td>
				<xsl:apply-templates select="image"/>
			</td>
			<td>
			<table>
				<tr>
					<td>
						<xsl:apply-templates select="title"/>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:apply-templates select="text"/>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		</table>
	</xsl:template>

</xsl:stylesheet>