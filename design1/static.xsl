<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="static">
		<html>
			<head>
				<xsl:apply-templates select="title"/>
				<link href="design1/bootstrap.css" rel="stylesheet" media="screen"/>
				<link href="design1/bootstrap-responsive.css" rel="stylesheet" media="screen"/>
				<link href="design1/af.css" rel="stylesheet"/>
			</head>
			<body>
				<div class="af-header">
					<div class="container">
						<xsl:apply-templates select="logo"/>
					</div>
				</div>
				<div class="container">
					<div class="navbar">
						<div class="navbar-inner">
							<xsl:apply-templates select="menu"/>
							<xsl:apply-templates select="topmenu"/>
						</div>
					</div>
					<div class="row">
						<div class="span12 result_global"/>
					</div>
					<xsl:apply-templates select="content"/>
				</div>
				<script type="text/javascript" src="design1/jquery.js"/>
				<script type="text/javascript" src="design1/bootstrap.js"/>
				<xsl:if test="//form">
					<xsl:copy-of select="$form_common"/>
				</xsl:if>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="static/title">
		<title>
			<xsl:apply-templates select="text"/>
		</title>>
	</xsl:template>

	<xsl:template match="static/logo">
		<h1>
			<xsl:apply-templates select="document('msg.xml')//other/logo"/>
		</h1>
		<p class="lead">
			<xsl:apply-templates select="document('msg.xml')//other/logo_descr"/>
		</p>
	</xsl:template>

</xsl:stylesheet>