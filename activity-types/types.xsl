<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
  <xsl:template match="/">
    <xsl:result-document href="overview.md" method="text">
      <xsl:text># Activity Types

An of activity types that are defined in services and APIs that are concerned with physical activities such as hiking, walking, running, or cycling.

So far the following </xsl:text>
      <xsl:value-of select="count(//API)"/>
      <xsl:text> APIs (with a total of </xsl:text>
      <xsl:value-of select="count(//API/activity)"/>
      <xsl:text> activity types) have been taken into consideration:&#xa;&#xa;</xsl:text>
      <xsl:for-each select="//API">
        <xsl:sort select="@name"/>
        <xsl:text>* [</xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text>](API/</xsl:text>
        <xsl:value-of select="@id"/>
        <xsl:text>.md) (</xsl:text>
        <xsl:value-of select="count(activity)"/>
        <xsl:text> activity types)&#xa;</xsl:text>
      </xsl:for-each>
    </xsl:result-document>
    <xsl:for-each select="//API">
      <xsl:result-document href="API/{@id}.md" method="text">
        <xsl:value-of select="concat('[', @name, '](', @href, ')')"/>
        <xsl:text>&#xa;=============&#xa;&#xa;</xsl:text>
        <xsl:for-each select="activity">
          <xsl:value-of select="concat('* ', @name, '&#xa;')"/>
        </xsl:for-each>
      </xsl:result-document>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>