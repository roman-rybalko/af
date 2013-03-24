<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="topmenu">
		<div class="navbar">
			<div class="navbar-inner">
				<ul class="nav">
					<xsl:apply-templates select="item"/>
				</ul>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="topmenu/item[@link]">
		<li>
			<a href="{@link}">
				<xsl:apply-templates select="logo"/>
				<xsl:value-of select="text"/>
			</a>
		</li>
	</xsl:template>

	<xsl:template match="topmenu/item[@selected]">
		<li class="active">
			<xsl:apply-templates select="logo"/>
			<xsl:value-of select="text"/>
		</li>
	</xsl:template>

	<xsl:template match="topmenu/item/logo[@type='lock']">
		<div class="icon-lock"/>
	</xsl:template>

	<xsl:template match="topmenu/item/logo[@type='profile']">
		<div class="icon-edit"/>
	</xsl:template>

	<xsl:template match="menu">
		<div class="navbar">
			<div class="navbar-inner">
				<ul class="nav">
					<xsl:apply-templates select="item"/>
				</ul>
			</div>
		</div>
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
		<div class="icon-list"/>
	</xsl:template>

	<xsl:template match="menu/item/logo[@type='bars']">
		<div class="icon-signal"/>
	</xsl:template>

	<xsl:template match="menu/item/logo[@type='price']">
		<div class="icon-tags"/>
	</xsl:template>

	<xsl:template match="menu/item/logo[@type='people']">
		<div class="icon-user"/>
	</xsl:template>

	<xsl:template match="menu/item/logo[@type='gear']">
		<div class="icon-cog"/>
	</xsl:template>

</xsl:stylesheet>