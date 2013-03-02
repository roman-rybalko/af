<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="static">
		<html>
			<head>
				<title>
					<xsl:value-of select="title"/>
				</title>
			</head>
			<body>
				<xsl:if test="//form">
					<xsl:copy-of select="$form_common"/>
				</xsl:if>
				<xsl:apply-templates select="logo"/>
				<xsl:apply-templates select="topmenu"/>
				<xsl:apply-templates select="menu"/>
				<xsl:apply-templates select="content"/>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="static/logo[lang='ru']">
		<img src="design_template/logo_ru.jpg" align="left"/>
	</xsl:template>

</xsl:stylesheet>