"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMachineViz,
	#superclass : #PackageManifest,
	#category : #'MachineViz-Manifest'
}

{ #category : #'code-critics' }
ManifestMachineViz class >> ruleGRGuradGuardClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#MVVizRobMachine #buildMachineOnView:andCanvas: #false)) #'2019-05-04T18:42:26.050576-04:00') )
]

{ #category : #'code-critics' }
ManifestMachineViz class >> ruleRBGuardingClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#MVVizRobMachine #buildMachineOnView:andCanvas: #false)) #'2019-05-04T18:42:34.195411-04:00') )
]
