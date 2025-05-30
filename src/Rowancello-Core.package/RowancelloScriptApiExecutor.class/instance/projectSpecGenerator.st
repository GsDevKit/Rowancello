execution
projectSpecGenerator
    baselineArg
        ifNotNil: [ 
            configurationArg ifNotNil: [ self error: ' baseline: and configuration: are both be specified' ].
            projectArg ifNotNil: [ self error: ' baseline: and project are both be specified' ].
            ^ RowancelloBaselineSpecGenerator new
                target: baselineArg;
                yourself ].
    configurationArg
        ifNotNil: [ 
            baselineArg ifNotNil: [ self error: ' baseline: and configuration: are both be specified' ].
            projectArg ifNotNil: [ self error: ' configuration and project are both be specified' ].

self error: 'Not yet implemented'.
            ^ MetacelloConfigurationSpecGenerator new
                target: configurationArg;
                yourself ].
    projectArg
        ifNotNil: [ 
            configurationArg ifNotNil: [ self error: ' project and configuration: are both be specified' ].
            baselineArg ifNotNil: [ self error: ' baseline: and project are both be specified' ].
 self error: 'Not yet implemented'.
           ^ MetacelloProjectSpecGenerator new
                target: projectArg;
                yourself ].
    self error: 'project, baseline, or configuration not specified'