#####################################################
# HelloID-Conn-Prov-Target-SAP-SuccessFactors
# 
# Version: 1.0.0
#####################################################

#region Functions
function New-BasicBase64 {
    [CmdletBinding()]
    param(
        [string]
        $UserName,
        [string]
        $PlainPassword       
    )
    $pair = "$($UserName):$($plainPassword)"
    $encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
    return ("Basic $encodedCreds")
}

<# .SYNOPSIS #>
function Set-SAPSFMailAddress {
    [CmdletBinding()]
    param(
        [parameter(Mandatory)] # PersonIdExternal Sap-SuccessFoctors
        [string]
        $PersonIdExternal,

        [parameter(Mandatory)] # Authentication Headers
        [System.Collections.Hashtable] 
        $Headers, 
        
        [parameter(Mandatory)] # URL of Sap-SuccessFoctors
        [string]
        $Url,

        [parameter(Mandatory)]
        [string]
        $MailAddress,

        [parameter(Mandatory, ParameterSetName = 'EmailType')]  # If the email address is for example always Business, you can enter the ID of the email type in parameter EmailID and leave EmailType empty
        # this will skip a lookup at SAP-SuccessFactors
        [ValidateSet("Business", "Other", "Personal")]
        [string]
        $EmailType,

        [parameter(Mandatory, ParameterSetName = 'EmailID')] 
        [int]
        $EmailID,

        [parameter(Mandatory)] # In SAP-SuccessFactors you must have one Primary Eamil address. So if you mark the new Mailaddress primary the existing addresses are demoted as secondary.
        [bool]
        $IsPrimary
    )     
    try {               
        if ($PSCmdlet.ParameterSetName -eq 'EmailType' ) {          
            $resultEmailLabels = Invoke-SAPSFRestMethod -Url "$url/Picklist('ecEmailType')?`$expand=picklistOptions/picklistLabels" -headers  $Headers 
            $emailLabels = Format-PickListLabel -ResultLabels $resultEmailLabels
            $EmailID = $emailLabels[$EmailType]
        }

        $postBody = @(
            [ordered]@{
                __metadata   = @{
                    uri  = "$Url/PerEmail(emailType='$EmailID',personIdExternal='$PersonIdExternal')"
                    type = "SFOData.PerEmail"
                }
                emailType    = "$EmailID"
                isPrimary    = $IsPrimary
                emailAddress = $MailAddress
            }
        )
        $getUserEmailRequestURL = $Url + '/PerEmail?$filter=personIdExternal eq ' + "$PersonIdExternal"
        $currentSAPSuccessFactors = (Invoke-RestMethod -Headers $Headers -Uri $getUserEmailRequestURL -Method Get).d.results
        $currentSAPPrimaryEmailAddress = $currentSAPSuccessFactors | Where-Object { $_.isPrimary -eq "True" }
            
        #Check if there is allready a primary addres in SAP
        if ($isPrimary -eq $true -and $emailId -ne $currentSAPPrimaryEmailAddress.emailType) {
            $postBodyExistingSAPEmail = @{
                __metadata = @{
                    uri  = "$Url/PerEmail(emailType='$($currentSAPPrimaryEmailAddress.emailType)',personIdExternal='$PersonIdExternal')"
                    type = "SFOData.PerEmail"
                }
                isPrimary  = $false
            }
            $postBody += $postBodyExistingSAPEmail
        }        
        $jsonBody = ConvertTo-Json -InputObject $postBody 

        $updateUrl = $Url + '/upsert?$format=json&purgeType=incremental'       
        return (Invoke-RestMethod -Headers $Headers -Uri $updateUrl -Method Post -ContentType "application/json" -Body  $jsonBody).d
    } catch {
        if ($_.ErrorDetails) {
            $errorExceptionDetails = $_.ErrorDetails
        }
        throw "Could not Set-SAPSFMailAddress  , message: $($_.Exception.Message), $errorExceptionDetails".Trim(" ")
    } 
}

<# .SYNOPSIS #>
function Set-SAPPersonalProperty {  
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]  # PersonIdExternal Sap-SuccessFoctors
        [string]
        $PersonIdExternal,

        [parameter(Mandatory)]  # Authentication Headers
        [System.Collections.Hashtable]
        $Headers,
        
        [parameter(Mandatory)]  # URL of Sap-SuccessFoctors
        [string]
        $Url,

        [parameter(Mandatory)]# Example Hashtable: @{    "CustomString5" = "JohnDoe@tools.com"}
        [System.Collections.Hashtable]  
        $PropertiesKeyValue
    )
    try {
        $postBody = [ordered]@{
            __metadata = @{
                uri  = "$Url/PerPersonal(personIdExternal='$PersonIdExternal',startDate=datetime'2020-01-01T00:00:00')"
                type = "SFOData.PerPersonal"
            }                       
        }           
        $postBody += $PropertiesKeyValue

        $jsonBody = ConvertTo-Json -InputObject $postBody 
        $updateUrl = $Url + '/upsert?$format=json&purgeType=incremental'
        $resultUpdateProperty = (Invoke-RestMethod -Headers $Headers -Uri $updateUrl -Method Post -ContentType "application/json" -Body  $jsonBody).d  
        return $resultUpdateProperty
    } catch {
        if ($_.ErrorDetails) {
            $errorExceptionDetails = $_.ErrorDetails
        }
        throw "Could not Set-SAPPersonalProperty  , message: $($_.Exception.Message), $errorExceptionDetails".Trim(" ")
    } 
}

function Invoke-SAPSFRestMethod { 
    [CmdletBinding()]
    param (
        [parameter(Mandatory)]  
        [string]
        $Url,

        [System.Collections.Hashtable]
        $headers,

        [int]
        $BatchSize = 250
    )
    try {       
        $offset = 0       
        [System.Collections.Generic.List[PSCustomObject]]$returnValue = @() 
        while ($returnValue.count -eq $offset) {    
          
            # Make sure function works with and wihtout query parameters in the Url
            if ($Url.Contains("?")) {
                $urlWithOffSet = $Url + "&`$skip=$offset&`$top=$BatchSize" 
            } else {
                $urlWithOffSet = $Url + "?`$skip=$offset&`$top=$BatchSize" 
            }
            
            $rawResponse = Invoke-RestMethod -Uri $urlWithOffSet.ToString() -Method GET -ContentType "application/json" -Headers $headers

            if ($rawResponse.d.results.count -gt 0) {
                [System.Collections.Generic.List[PSCustomObject]]$partialResult = $rawResponse.d.results    
            } else {
                [System.Collections.Generic.List[PSCustomObject]]$partialResult = $rawResponse.d
            }  
            $returnValue.AddRange($partialResult)
            $offset += $BatchSize
        }             
    } catch {
        if ($_.ErrorDetails) {
            $errorExceptionDetails = $_.ErrorDetails
        }
        throw "Could not Invoke-SAPSFRestMethod, message: $($_.Exception.Message), $errorExceptionDetails".Trim(" ")
    }
    return $returnValue
}

function Format-PickListLabel($ResultLabels) {
    $labelList = @{ }
    foreach ($label in $resultLabels.picklistOptions.results) {
        $labelList += @{
            ($label.picklistLabels.results | where { $_.locale -eq "en_US" }).label = $label.id  
        } 
    }
    return $labelList
}
#endregion Functions

$verbosePreference = "continue"

#Initialize default properties
$config = ConvertFrom-Json $configuration 
if ($config.UseUsernamePassword) {
    $Headers = @{
        Authorization = (New-BasicBase64 -UserName $config.userName -PlainPassword $config.password )
        accept        = "application/json"
    }	
} else {
    $Headers = @{
        APIKey = $config.APIKey
        accept = "application/json"
    }	
}
$url = $config.url.trim("/")

$p = $person | ConvertFrom-Json;
$m = $manager | ConvertFrom-Json;
$success = $False;
$auditMessage = "identity for person " + $p.DisplayName + " not updated successfully";

#Change mapping here
$account = [PSCustomObject]@{
    DisplayName       = $p.DisplayName;
    FirstName         = $p.Name.NickName;
    LastName          = $p.Name.FamilyName;
    ExternalId        = $p.ExternalId   
    UserPrincipalName = $p.Accounts.MicrosoftActiveDirectory.userPrincipalName;
    SAPPrimaryEmail   = ($p.Accounts.MicrosoftActiveDirectory.proxyAddresses | Where-Object { $_ -cmatch "SMTP" }).replace("SMTP:", "") + ".com" ## 
}

if (-Not($dryRun -eq $true)) {
    try {  
        #Update Email   
        $SAPSFMailAddress = @{
            PersonIdExternal = $account.ExternalId
            MailAddress      = $account.SAPPrimaryEmail
            EMailType        = "Business"
            # -or EmailID = 8446
            IsPrimary        = $true
            Headers          = $Headers
            url              = $url
        } 
        $result = Set-SAPSFMailAddress @SAPSFMailAddress -ErrorAction Stop

        #Update UserPrincipalName
        $propertiesKeyValue = @{  # In Sap a UserPrincipalName must be added in a CustomField
            "CustomString51" = $account.userPrincipalName
            #"businessLastName" = $account.UserPrincipalName
        }   
        $result = Set-SAPPersonalProperty -Url $url -PersonIdExternal $account.ExternalId -Headers $Headers -PropertiesKeyValue $propertiesKeyValue -ErrorAction Stop
    
        $success = $True; 
        $auditMessage = "Successfully Updated identity for person " + $p.DisplayName;
    } catch {
        $auditMessage = " . $($_.Exception.Message)"
    }   
}

#build up result
$result = [PSCustomObject]@{
    Success          = $success;
    AccountReference = $account.externalId
    AuditDetails     = $auditMessage;
    Account          = $account;
};

#send result back
Write-Output $result | ConvertTo-Json -Depth 10