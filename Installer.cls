Class Advent.Installer
{

XData MyInstall [ XMLNamespace = INSTALLER ]
{
<Manifest>
  <Default Name="NAMESPACE" Value="ADVENT"/>
  <Default Name="DBNAME" Value="${NAMESPACE}"/>
  <Default Name="APPPATH" Dir="/opt/advent/" />
  <Default Name="SOURCESPATH" Dir="${APPPATH}src" />

  <Invoke Class="${CURRENTCLASS}" Method="SetSecurity" CheckStatus="true">
    <Arg Value="Security.Services"/>
    <Arg Value="%Service_Terminal"/>
    <Arg Value="AutheEnabled"/>
    <Arg Value="64"/>
  </Invoke>

  <Invoke Class="${CURRENTCLASS}" Method="SetSecurity" CheckStatus="true">
    <Arg Value="Security.Users"/>
    <Arg Value="UnknownUser"/>
    <Arg Value="Roles"/>
    <Arg Value="%ALL"/>
  </Invoke>

  <Invoke Class="${CURRENTCLASS}" Method="SetSecurity" CheckStatus="true">
    <Arg Value="Security.Users"/>
    <Arg Value="_SYSTEM"/>
    <Arg Value="ChangePassword"/>
    <Arg Value="0"/>
  </Invoke>

  <Invoke Class="${CURRENTCLASS}" Method="SetSecurity" CheckStatus="true">
    <Arg Value="Security.Users"/>
    <Arg Value="Admin"/>
    <Arg Value="ChangePassword"/>
    <Arg Value="0"/>
  </Invoke>

  <Namespace Name="${NAMESPACE}" Code="${DBNAME}" Data="${DBNAME}" Create="yes" Ensemble="0">
    <Configuration>
        <Database Name="${DBNAME}" Dir="${MGRDIR}/${DBNAME}" Create="yes"/>
    </Configuration>

    <Import File="${SOURCESPATH}" Recurse="1"/>
  </Namespace>
</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  do %code.WriteLine($char(9)_"set pVars(""CURRENTCLASS"")="""_%classname_"""")
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "MyInstall")
}

ClassMethod SetSecurity(pClass = "", pId, pName = "", pValue = "")
{
  new $NAMESPACE
  set $NAMESPACE = "%SYS"
  quit:pClass=""
  quit:pName=""

  kill params
  set params(pName) = pValue

  quit $CLASSMETHOD(pClass, "Modify", pId, .params)
}

}
