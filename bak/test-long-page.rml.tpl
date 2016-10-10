<?xml version="1.0" encoding="iso-8859-1" standalone="no" ?>
<!DOCTYPE document SYSTEM "rml_1_0.dtd">
<document>
    <template pagesize="21cm, 29.7cm">
        <pageTemplate id="main">
            <pageGraphics>
                <setFont name="Helvetica" size="10"/>
                <drawString x="2cm" y="27.7cm">PT. Properindo Jasatama</drawString>
                <drawRightString x="19cm" y="27.7cm">www.opensipkd.com</drawRightString>
            </pageGraphics>
            <pageGraphics>
                <setFont name="Helvetica" size="10"/>
                <drawCenteredString x="9.5cm" y="1.5cm">Halaman <pageNumber/> / <getName id="last-page" default="1"/></drawCenteredString>
                <drawRightString x="19cm" y="1.5cm">{waktu}</drawRightString>
            </pageGraphics>
            <frame id="content" x1="2cm" y1="2cm" width="17cm" height="25cm"/>
        </pageTemplate>
    </template>
    <stylesheet>
        <paraStyle name="heading1"
            fontName="Helvetica-Bold"
            fontSize="14"
            spaceAfter="15"/>
        <paraStyle name="body"
            fontName="Helvetica"
            fontSize="12"
            spaceAfter="10"/>
        <blockTableStyle id="table">
            <lineStyle kind="GRID" colorName="black"/>
        </blockTableStyle>
    </stylesheet>
    <story>
        <para style="heading1">Daftar Peserta</para>
        <para style="body">Berikut ini daftar peserta yang dikarang oleh komputer. Susunan nama dan nomor handphone
        dibuat menggunakan modul random.</para>
        <blockTable colWidths="1cm,2cm,5cm,5cm" style="table" repeatRows="1">
            <tr>
                <td>No.</td>
                <td>ID</td>
                <td>Nama</td>
                <td>Nomor HP</td>
            </tr>
            {rows}
        </blockTable>
        <nextPage/>
        <para style="body">Ini contoh pergantian halaman.</para>
        <namedString id="last-page"><pageNumber/></namedString>
    </story>
</document>
