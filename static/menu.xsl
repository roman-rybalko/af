<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="menu">
		<table>
			<tr>
				<xsl:apply-templates select="item" />
			</tr>
		</table>
	</xsl:template>

	<xsl:template match="menu/item[@name='description']">
		<td>
			<xsl:if test="@link">
				<a href="{@link}">
					Описание
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				Описание
			</xsl:if>
		</td>
	</xsl:template>

	<xsl:template match="menu/item[@name='pricing']">
		<td>
			<xsl:if test="@link">
				<a href="{@link}">
					Цены
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				Цены
			</xsl:if>
		</td>
	</xsl:template>

	<xsl:template match="menu/item[@name='contacts']">
		<td>
			<xsl:if test="@link">
				<a href="{@link}">
					О нас
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				О нас
			</xsl:if>
		</td>
	</xsl:template>

	<xsl:template match="menu/item[@name='kb']">
		<td>
			<xsl:if test="@link">
				<a href="{@link}">
					База знаний
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				База знаний
			</xsl:if>
		</td>
	</xsl:template>

	<xsl:template match="menu/item[@name='forum']">
		<td>
			<xsl:if test="@link">
				<a href="{@link}">
					Форум
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				Форум
			</xsl:if>
		</td>
	</xsl:template>

	<xsl:template match="menu/item[@name='cabinet']">
		<td>
			<xsl:if test="@link">
				<a href="{@link}">
					Личный кабинет
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				Личный кабинет
			</xsl:if>
		</td>
	</xsl:template>

</xsl:stylesheet>