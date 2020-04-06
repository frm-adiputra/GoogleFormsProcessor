using GoogleFormsProcessor

GoogleFormsProcessor.setOtherName("a")

@test GoogleFormsProcessor.otherName == "a"

@test otherColName(:A) == Symbol("A -- _a_")
