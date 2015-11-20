<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2" exclude-result-prefixes="xs" version="3.0" xmlns:my="tag:xslt-can-be-weird">
  <xsl:output method="text" />
  <xsl:param name="indent" select="xs:nonNegativeInteger(0)" as="xs:nonNegativeInteger"/>
  <xsl:param name="spacing" select="xs:nonNegativeInteger(2)" as="xs:nonNegativeInteger"/>
  
  <xsl:template match="TrainingCenterDatabase">
    <xsl:text>{ "JTT" : [&#xa;</xsl:text>
    <xsl:apply-templates select="Activities/Activity">
      <xsl:with-param name="indent" select="$indent + $spacing"/>
    </xsl:apply-templates>
    <xsl:text>] }&#xa;</xsl:text>
  </xsl:template>
  
  <xsl:template match="Activity">
    <xsl:param name="indent"/>
    <xsl:value-of select="concat(my:indent($indent), '{ &quot;track&quot; : {&#xa;')"/>
    <xsl:if test="exists(Notes)">
      <xsl:value-of select="concat(my:indent($indent), '  &quot;desc&quot; : &quot;', Notes/text(), '&quot;,&#xa;')"/>
    </xsl:if>
    <xsl:if test="exists(Lap)">
      <xsl:value-of select="concat(my:indent($indent), '  &quot;segments&quot; : [&#xa;')"/>
      <xsl:value-of select="concat(my:indent($indent), '    { &quot;data-fields&quot; : [')"/>
      <xsl:text>"latitude", "longitude", "elevation", "time", "HR", "distance"</xsl:text>
      <xsl:text> ] }, &#xa;</xsl:text>
      <xsl:apply-templates select="Lap">
        <xsl:with-param name="indent" select="$indent + $spacing"/>
      </xsl:apply-templates>
      <xsl:value-of select="concat(my:indent($indent), '  ]&#xa;')"/>
    </xsl:if>
    <xsl:value-of select="concat(my:indent($indent), '} }&#xa;')"/>
  </xsl:template>
  
  <xsl:template match="Lap">
    <xsl:param name="indent"/>
    <xsl:value-of select="concat(my:indent($indent), '[&#xa;')"/>
    <xsl:for-each select="Track/Trackpoint">
      <xsl:value-of select="concat(my:indent($indent), '  [ ')"/>
      <xsl:value-of select="concat(Position/LatitudeDegrees/text(), ', ', Position/LongitudeDegrees/text(), ', ', AltitudeMeters/text(), ', &quot;', Time/text(), '&quot;, ', HeartRateBpm/Value/text(), ', ', DistanceMeters/text())"/>
      <xsl:value-of select="concat(']', if ( not(position() eq last()) ) then ',' else () ,'&#xa;')"/>
    </xsl:for-each>
    <xsl:value-of select="concat(my:indent($indent), ']', if ( not(position() eq last()) ) then ',' else () ,'&#xa;')"/>
  </xsl:template>
  
  <xsl:function name="my:indent">
    <xsl:param name="indent"/>
    <xsl:value-of select=" for $i in 1 to $indent return ' ' "/>
  </xsl:function>

</xsl:stylesheet>
