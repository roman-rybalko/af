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

	<xsl:template match="menu/item[@name='benefits']">
		<td>
			<xsl:if test="@link">
				<a href="{@link}">
					Преимущества
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				Преимущества
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

	<xsl:template match="menu/item[@name='stats']">
		<td>
			<xsl:if test="@link">
				<a href="{@link}">
					Статистика
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				Статистика
			</xsl:if>
		</td>
	</xsl:template>

	<xsl:template match="menu/item[@name='settings']">
		<td>
			<xsl:if test="@link">
				<a href="{@link}">
					Настройки
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				Настройки
			</xsl:if>
		</td>
	</xsl:template>

	<xsl:template match="menu/item[@name='users']">
		<td>
			<xsl:if test="@link">
				<a href="{@link}">
					Пользователи
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				Пользователи
			</xsl:if>
		</td>
	</xsl:template>

	<xsl:template match="menu/item[@name='trace']">
		<td>
			<xsl:if test="@link">
				<a href="{@link}">
					Трассировка
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				Трассировка
			</xsl:if>
		</td>
	</xsl:template>

	<xsl:template match="menu/item[@name='trash']">
		<td>
			<xsl:if test="@link">
				<a href="{@link}">
					Корзина
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				Корзина
			</xsl:if>
		</td>
	</xsl:template>

	<xsl:template match="menu/item[@name='billing']">
		<td>
			<xsl:if test="@link">
				<a href="{@link}">
					Финансы
				</a>
			</xsl:if>
			<xsl:if test="@selected">
				Финансы
			</xsl:if>
		</td>
	</xsl:template>

</xsl:stylesheet>