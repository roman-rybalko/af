<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="static">
		<html>
			<head>
				<xsl:apply-templates select="title"/>
				<link href="design1/bootstrap.css" rel="stylesheet"/>
				<link href="design1/bootstrap-responsive.css" rel="stylesheet"/>
				<link href="design1/af.css" rel="stylesheet"/>
			</head>
			<body>
				<div id="af-page">
					<div id="af-header">
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
							<div id="result_global" class="span12"/>
						</div>
						<xsl:apply-templates select="content"/>
					</div>
					<div id="af-page-push"/>
				</div>
				<div id="af-footer">
					<div class="container">
						<p class="muted af-footer-line-1">
							<xsl:apply-templates select="document('msg.xml')//other/footer_1"/>
						</p>
						<p class="muted af-footer-line-2">
							<xsl:apply-templates select="document('msg.xml')//other/footer_2"/>
						</p>
					</div>
				</div>
				<script type="text/javascript" src="design1/jquery.js"/>
				<script type="text/javascript" src="design1/bootstrap.js"/>
				<xsl:if test="//form">
					<xsl:copy-of select="$form_common"/>
				</xsl:if>
				<xsl:if test="//image">
					<xsl:copy-of select="$image_common"/>
				</xsl:if>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="static/title">
		<title>
			<xsl:apply-templates select="text"/>
		</title>
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