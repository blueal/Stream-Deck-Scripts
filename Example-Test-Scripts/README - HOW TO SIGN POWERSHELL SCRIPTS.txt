#instructions for creating certificates
#https://community.spiceworks.com/how_to/153255-windows-10-signing-a-powershell-script-with-a-self-signed-certificate

#Type into Powershell 
New-SelfSignedCertificate -CertStoreLocation cert:\currentuser\my `
-Subject "CN=Local Code Signing" `
-KeyAlgorithm RSA `
-KeyLength 2048 `
-Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" `
-KeyExportPolicy Exportable `
-KeyUsage DigitalSignature `
-Type CodeSigningCert `
-NotAfter (Get-Date).AddYears(10)  #Set Expiration to 10 years from now!

#Open Certificate Manager
certmgr /s my


#Expand the "Personal" folder, select Certificates. Right click the new "Local Code Signing" certificate, and Copy.

#Paste into "Trusted Root Certification Authorities" and into "Trusted Publishers" stores.

#From a Powershell prompt, run these two commands:
#NAVIGATE IN POWERSHELL TO FILE LOCATION

cd 'C:\PATH\TO\SCRIPT'

$cert = @(Get-ChildItem cert:\CurrentUser\My -CodeSigning)[0]
Set-AuthenticodeSignature .\SCRIPTFILENAME.ps1 $cert