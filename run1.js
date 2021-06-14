

  forall c in ./all {
    if (c/ready && not c/busy) {
      let m = c/popInputQueue
      c/react (m)
      forall m in c/iterateOutputs {
        let container = ../c
	send container/deliver m
      }
      send ./found true
    }
  }
}
