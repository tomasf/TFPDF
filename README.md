TFPDF is an Objective-C wrapper for the CGPDF parsing API.

# PDF object types
<table>
    <tr>
        <th>Type</th>
        <th>CGPDF</th>
        <th>TFPDF</th>

        <tr><td>Boolean</td> <td>CGPDFBoolean (unsigned char)</td> <td>NSNumber</td></tr>
        <tr><td>Integer</td> <td>CGPDFInteger (long)</td> <td>NSNumber</td></tr>
        <tr><td>Real</td> <td>CGPDFReal (CGFloat)</td> <td>NSNumber</td></tr>
        <tr><td>Null</td> <td>NULL</td> <td>NSNull</td></tr>
        <tr><td>String</td> <td>CGPDFStringRef</td> <td>NSString</td></tr>
        <tr><td>Name</td> <td>char *</td> <td>NSString</td></tr>
        <tr><td>Array</td> <td>CGPDFArrayRef</td> <td>TFPDFArray</td></tr>
        <tr><td>Dictionary</td> <td>CGPDFDictionaryRef</td> <td>TFPDFDictionary</td></tr>
        <tr><td>Stream</td> <td>CGPDFStreamRef</td> <td>TFPDFStream</td></tr>
    </tr>    
</table>