<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="cgi">
		<xsl:apply-templates select="content"/>
	</xsl:template>
	
</xsl:stylesheet>