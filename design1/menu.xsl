<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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

</xsl:stylesheet>