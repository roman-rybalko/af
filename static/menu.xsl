<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="topmenu">
		<div align="right">
			<table>
				<xsl:apply-templates select="item"/>
			</table>
		</div>
	</xsl:template>

	<xsl:template match="topmenu/item">
		<tr><td>
			<a href="{@link}">
				<xsl:apply-templates select="logo"/>
				<xsl:value-of select="."/>
			</a>
		</td></tr>
	</xsl:template>

	<xsl:template match="topmenu/item/logo">
		[none]
	</xsl:template>

	<xsl:template match="topmenu/item/logo[@type='lock']">
		[lock]
	</xsl:template>

	<xsl:template match="topmenu/item/logo[@type='profile']">
		[profile]
	</xsl:template>

	<xsl:template match="menu">
		<table>
			<tr>
				<xsl:apply-templates select="item"/>
			</tr>
		</table>
	</xsl:template>
	
	<xsl:template match="menu/item">
		<td>
			<a href="{@link}">
				<xsl:apply-templates select="logo"/>
				<xsl:value-of select="."/>
			</a>
		</td>
	</xsl:template>

	<xsl:template match="menu/item[@selected]">
		<td>
			<xsl:apply-templates select="logo"/>
			<xsl:value-of select="."/>
		</td>
	</xsl:template>

	<xsl:template match="menu/item/logo">
		[none]
	</xsl:template>
	
	<xsl:template match="menu/item/logo[@type='sheet']">
		[sheet]
	</xsl:template>

	<xsl:template match="menu/item/logo[@type='bars']">
		[bars]
	</xsl:template>

	<xsl:template match="menu/item/logo[@type='price']">
		[price]
	</xsl:template>

	<xsl:template match="menu/item/logo[@type='people']">
		[people]
	</xsl:template>

	<xsl:template match="menu/item/logo[@type='gear']">
		[gear]
	</xsl:template>

</xsl:stylesheet>