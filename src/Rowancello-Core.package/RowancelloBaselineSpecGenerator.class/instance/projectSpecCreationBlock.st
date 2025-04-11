accessing
projectSpecCreationBlock
    ^ [ :projectName | {(RowancelloMCBaselineProject new baselineOfProjectSpec name: projectName)} ]