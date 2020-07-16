function Get-HardcodedStringArrayFromMultilineString {
    param ([string]$value, [bool]$ignoreemptyline = $true, [bool]$trimwhitespace = $true)

    if ($null -eq $value -or -not $value.Contains([System.Environment]::NewLine)) {
        write-error "Input is not a multiline string."
        $null
    }
    else {
        $linearray = $value.Split([System.Environment]::NewLine)
        $resultsb = [System.Text.StringBuilder]::new()
        $resultsb.Append("(") | out-null

        foreach ($element in $linearray) {
            if ($ignoreemptyline -and $element -eq [string]::Empty) {
                continue
            }
            if ($trimwhitespace) {
                $element = $element.Trim()
            }
            $resultsb.Append('"') | out-null
            $resultsb.Append($element) | out-null
            $resultsb.Append('"') | out-null
            if ($linearray.IndexOf($element) -ne $linearray.Length - 1) {
                #not lastElement add seperator
                $resultsb.Append(",") | out-null
            }         
        }
        $result = $resultsb.ToString().Substring(0,$resultsb.ToString().LastIndexOf(",")) + ")"
        
        $result
    }
}