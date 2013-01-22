<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>

	<xsl:include href="menu.xsl" />
	<xsl:include href="content.xsl" />

	<xsl:template match="root">
		<html>
			<head>
				<title>
					Title - <xsl:value-of select="menu/item[@selected]/@name" />
				</title>
			</head>
			<body>
				логотип: ПРОДВИНУТАЯ ФИЛЬТРАЦИЯ
				<xsl:apply-templates select="menu" />
				<xsl:apply-templates select="content" />
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
