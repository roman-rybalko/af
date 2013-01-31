<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="form[@name='login']">
		Введите учетные данные
		<form id="{@name}" action="{@link}">
			<xsl:apply-templates select="input" />
			<input type="submit" value="Вход"/>
		</form>
		<div id="{@name}result"></div>
		<script>
			formHandler("#<xsl:value-of select="@name"/>", "#<xsl:value-of select="@name"/>result", "<xsl:value-of select="@link"/>");
		</script>
	</xsl:template>

	<xsl:template match="input[@name='login']">
		Логин: <input name="{@name}" type="text" />
	</xsl:template>

	<xsl:template match="input[@name='password']">
		Пароль: <input name="{@name}" type="password" />
	</xsl:template>

	<xsl:template match="form[@name='register']">
		Регистрация
		<form id="{@name}" action="{@link}">
			<xsl:apply-templates select="input" />
			<input type="submit" value="Зарегистрировать"/>
		</form>
		<div id="{@name}result"></div>
		<script>
			formHandler("#<xsl:value-of select="@name"/>", "#<xsl:value-of select="@name"/>result", "<xsl:value-of select="@link"/>");
		</script>
	</xsl:template>

	<xsl:template match="input[@name='password1']">
		Пароль: <input name="{@name}" type="password" />
	</xsl:template>

	<xsl:template match="input[@name='password2']">
		Подтвердить пароль: <input name="{@name}" type="password" />
	</xsl:template>

	<xsl:template match="input[@name='email']">
		Электронная почта: <input name="{@name}" type="text" />
	</xsl:template>

	<xsl:template match="form[@name='settings']">
		Настройки
		<form id="{@name}" action="{@link}">
			<xsl:apply-templates select="input" />
			<input type="submit" value="Сохранить"/>
		</form>
		<div id="{@name}result"></div>
		<script>
			formHandler("#<xsl:value-of select="@name"/>", "#<xsl:value-of select="@name"/>result", "<xsl:value-of select="@link"/>");
		</script>
	</xsl:template>

	<xsl:template match="input[@name='text1']">
		Текстовое поле: <input name="{@name}" type="text" value="{@data}"/>
		<br/>
	</xsl:template>

	<xsl:template match="input[@name='drop1']">
		Выпадающий список:
		<select name="{@name}">
			<xsl:apply-templates select="option" />
		</select>
		<br/>
	</xsl:template>
	
	<xsl:template match="input[@name='drop1']/option">
		<xsl:if test="@selected">
			<option value="{@value}" selected="1"><xsl:value-of select="@value"/></option>
		</xsl:if>
		<xsl:if test="not(@selected)">
			<option value="{@value}"><xsl:value-of select="@value"/></option>
		</xsl:if>
	</xsl:template>	

	<xsl:template match="input[@name='radio1']">
		Радио-кнопки:
		<xsl:apply-templates select="option" />
		<br/>
	</xsl:template>

	<xsl:template match="input[@name='radio1']/option">
		<xsl:value-of select="@value"/>:
		<xsl:if test="@selected">
			<input type="radio" name="{../@name}" value="{@value}" checked="1"/>
		</xsl:if>
		<xsl:if test="not(@selected)">
			<input type="radio" name="{../@name}" value="{@value}"/>
		</xsl:if>
		<br/>
	</xsl:template>	

	<xsl:template match="input[@name='multi1']">
		Список с множественным выбором:
		<select name="{@name}" multiple="1">
			<xsl:apply-templates select="option" />
		</select>
		<br/>
	</xsl:template>
	
	<xsl:template match="input[@name='multi1']/option">
		<xsl:if test="@selected">
			<option value="{@value}" selected="1"><xsl:value-of select="@value"/></option>
		</xsl:if>	
		<xsl:if test="not(@selected)">
			<option value="{@value}"><xsl:value-of select="@value"/></option>
		</xsl:if>	
	</xsl:template>
	
	<xsl:template match="input[@name='check1']">
		Кнопка 1 вкл-выкл:<br/>
		<xsl:if test="@selected">
			Вкл: <input type="radio" name="{@name}" value="1" checked="1"/><br/>
			Выкл: <input type="radio" name="{@name}" value="0" /><br/>
		</xsl:if>
		<xsl:if test="not(@selected)">
			Вкл: <input type="radio" name="{@name}" value="1"/><br/>
			Выкл: <input type="radio" name="{@name}" value="0" checked="1"/><br/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="input[@name='check2']">
		Кнопка 2 вкл-выкл:<br/>
		<xsl:if test="@selected">
			Вкл: <input type="radio" name="{@name}" value="1" checked="1"/><br/>
			Выкл: <input type="radio" name="{@name}" value="0" /><br/>
		</xsl:if>
		<xsl:if test="not(@selected)">
			Вкл: <input type="radio" name="{@name}" value="1"/><br/>
			Выкл: <input type="radio" name="{@name}" value="0" checked="1"/><br/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="form[@name='fail']">
		Проверка на сбой
		<form id="{@name}" action="{@link}">
			<input type="hidden" name="hid1" value="1"/>
			<input type="submit" value="Проверить"/>
		</form>
		<div id="{@name}result"></div>
		<script>
			formHandler("#<xsl:value-of select="@name"/>", "#<xsl:value-of select="@name"/>result", "<xsl:value-of select="@link"/>");
		</script>
	</xsl:template>

</xsl:stylesheet>