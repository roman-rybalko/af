<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="locale.xsl" />

	<xsl:template match="menu">
		<table>
			<tr>
				<xsl:apply-templates select="item" />
			</tr>
		</table>
	</xsl:template>

	<xsl:template match="menu/item">
		<td>
			Def:
			<xsl:if test="@link">
				<a href="{@link}">
					<xsl:value-of select="@name" />
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				<xsl:value-of select="@name" />
			</xsl:if>
		</td>
	</xsl:template>

	<xsl:template match="menu/item[@name='description']">
		<td>
			<xsl:if test="@link">
				<a href="{@link}">
					<xsl:value-of select="@name" />
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				<xsl:value-of select="@name" />
			</xsl:if>
		</td>
	</xsl:template>

	<xsl:template match="menu/item[@name='pricing']">
		<td>
			<xsl:if test="@link">
				<a href="{@link}">
					<xsl:value-of select="@name" />
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				<xsl:value-of select="@name" />
			</xsl:if>
		</td>
	</xsl:template>

</xsl:stylesheet>