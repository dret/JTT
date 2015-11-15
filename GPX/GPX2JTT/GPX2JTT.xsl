<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.topografix.com/GPX/1/1" xmlns:gpxtpx="http://www.garmin.com/xmlschemas/TrackPointExtension/v1" exclude-result-prefixes="xs" version="3.0" xmlns:my="tag:xslt-can-be-weird">
  <xsl:output method="text" />
  <xsl:param name="data-fields" select="document('data-fields.xml')/gpx-datafields/data-field"/>
  <xsl:param name="indent" select="xs:nonNegativeInteger(0)" as="xs:nonNegativeInteger"/>
  <xsl:param name="spacing" select="xs:nonNegativeInteger(2)" as="xs:nonNegativeInteger"/>
  
  <xsl:template match="gpx">
    <xsl:text>{ "JTT" : [&#xa;</xsl:text>
    <xsl:apply-templates select="trk">
      <xsl:with-param name="indent" select="$indent + $spacing"/>
    </xsl:apply-templates>
    <xsl:text>] }&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="trk">
    <xsl:param name="indent"/>
    <xsl:value-of select="concat(my:indent($indent), '{ &quot;track&quot; : {&#xa;')"/>
    <xsl:if test="exists(name)">
      <xsl:value-of select="concat(my:indent($indent), '  &quot;title&quot; : &quot;', name/text(), '&quot;,&#xa;')"/>
    </xsl:if>
    <xsl:if test="exists(desc)">
      <xsl:value-of select="concat(my:indent($indent), '  &quot;desc&quot; : &quot;', desc/text(), '&quot;,&#xa;')"/>
    </xsl:if>
    <xsl:if test="exists(trkseg)">
      <xsl:value-of select="concat(my:indent($indent), '  &quot;segments&quot; : [&#xa;')"/>
      <xsl:value-of select="concat(my:indent($indent), '    { &quot;data-fields&quot; : [')"/>
      <xsl:text>"latitude", "longitude", "elevation", "temperature", "HR"</xsl:text>
      <xsl:text> ] }, &#xa;</xsl:text>
      <xsl:apply-templates select="trkseg">
        <xsl:with-param name="indent" select="$indent + $spacing"/>
      </xsl:apply-templates>
      <xsl:value-of select="concat(my:indent($indent), '  ]&#xa;')"/>
    </xsl:if>
    <xsl:value-of select="concat(my:indent($indent), '} }&#xa;')"/>
  </xsl:template>
  
  <xsl:template match="trkseg">
    <xsl:param name="indent"/>
    <xsl:value-of select="concat(my:indent($indent), '[&#xa;')"/>
    <xsl:for-each select="trkpt">
      <xsl:value-of select="concat(my:indent($indent), '  [ ')"/>
      <xsl:value-of select="concat(@lat, ', ', @lon, ', ', ele, ', &quot;', time, '&quot;, ', extensions/gpxtpx:TrackPointExtension/gpxtpx:atemp, ', ', extensions/gpxtpx:TrackPointExtension/gpxtpx:hr)"/>
      <xsl:value-of select="concat(']', if ( not(position() eq last()) ) then ',' else () ,'&#xa;')"/>
    </xsl:for-each>
    <xsl:value-of select="concat(my:indent($indent), ']', if ( not(position() eq last()) ) then ',' else () ,'&#xa;')"/>
  </xsl:template>
  
  
  <xsl:function name="my:indent">
    <xsl:param name="indent"/>
    <xsl:value-of select="for $i in 1 to $indent return ' '"/>
  </xsl:function>

</xsl:stylesheet>
