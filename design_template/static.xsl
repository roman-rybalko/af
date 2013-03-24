<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="static">
		<html>
			<head>
				<title>
					<xsl:value-of select="title"/>
				</title>
				<link href="design_template/bootstrap.css" rel="stylesheet" media="screen"/>
				<link href="design_template/bootstrap-responsive.css" rel="stylesheet" media="screen"/>
			</head>
			<body>
				<script type="text/javascript" src="design_template/jquery.js"/>
				<script type="text/javascript" src="design_template/bootstrap.js"/>
				<xsl:if test="//form">
					<xsl:copy-of select="$form_common"/>
				</xsl:if>
				<div class="container">
					<div class="row">
						<div class="span9">
							<xsl:apply-templates select="logo"/>
						</div>
						<div class="span3">
							<xsl:apply-templates select="topmenu"/>
						</div>
					</div>
					<div class="row">
						<div class="span12">
							<xsl:apply-templates select="menu"/>
						</div>
					</div>
					<div class="row">
						<div class="span12">
							<xsl:apply-templates select="content"/>
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="static/logo[@lang='ru']">
		<img src="design_template/logo_ru.jpg"/>
		<br/>
	</xsl:template>

</xsl:stylesheet>