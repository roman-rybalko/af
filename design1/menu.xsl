<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="topmenu">
		<ul class="nav pull-right">
			<xsl:apply-templates select="item"/>
		</ul>
	</xsl:template>

	<xsl:template match="topmenu/item[@link]">
		<li>
			<a href="{@link}">
				<xsl:apply-templates select="logo"/>
				<xsl:apply-templates select="text"/>
			</a>
		</li>
	</xsl:template>

	<xsl:template match="topmenu/item[@selected]">
		<li class="active">
			<a href="#">
				<xsl:apply-templates select="logo"/>
				<xsl:value-of select="text"/>
			</a>
		</li>
	</xsl:template>

	<xsl:template match="topmenu/item/logo[@type='lock']">
		<span class="icon-lock"/>
	</xsl:template>

	<xsl:template match="topmenu/item/logo[@type='profile']">
		<span class="icon-edit"/>
	</xsl:template>

	<xsl:template match="menu">
		<ul class="nav">
			<xsl:apply-templates select="item"/>
		</ul>
	</xsl:template>

	<xsl:template match="menu/item[@link]">
		<li>
			<a href="{@link}">
				<xsl:apply-templates select="logo"/>
				<xsl:value-of select="text"/>
			</a>
		</li>
	</xsl:template>

	<xsl:template match="menu/item[@selected]">
		<li class="active">
			<a href="#">
				<xsl:apply-templates select="logo"/>
				<xsl:value-of select="text"/>
			</a>
		</li>
	</xsl:template>

	<xsl:template match="menu/item/logo[@type='sheet']">
		<span class="icon-list"/>
	</xsl:template>

	<xsl:template match="menu/item/logo[@type='bars']">
		<span class="icon-signal"/>
	</xsl:template>

	<xsl:template match="menu/item/logo[@type='price']">
		<span class="icon-tags"/>
	</xsl:template>

	<xsl:template match="menu/item/logo[@type='people']">
		<span class="icon-user"/>
	</xsl:template>

	<xsl:template match="menu/item/logo[@type='gear']">
		<span class="icon-cog"/>
	</xsl:template>

</xsl:stylesheet>