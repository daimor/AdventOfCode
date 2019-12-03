Class Advent.Installer
{

XData MyInstall [ XMLNamespace = INSTALLER ]
{
<Manifest>
  <Default Name="AppDir" Value="#{$system.Process.CurrentDirectory()}"/>
  <Default Name="SourceDir" Value="${AppDir}src"/>
  <Default Name="DbDir" Value="${AppDir}db"/>

  <Default Name="NAMESPACE" Value="ADVENT"/>
  <Default Name="DBNAME" Value="${NAMESPACE}"/>

  <Namespace Name="${NAMESPACE}" Code="${DBNAME}" Data="${DBNAME}" Create="yes" Ensemble="0">
    <Configuration>
        <Database Name="${DBNAME}" Dir="${DbDir}" Create="yes"/>
    </Configuration>

    <Import File="${SourceDir}" Recurse="1"/>
  </Namespace>
</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  do %code.WriteLine($char(9)_"set pVars(""CURRENTCLASS"")="""_%classname_"""")
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "MyInstall")
}

}
