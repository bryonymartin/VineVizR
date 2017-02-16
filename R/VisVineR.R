VisVineR <-
  function(RVM,
           group,
           group.size,
           colours,
           shape = c(
             "square",
             "triangle",
             "box",
             "circle",
             "dot",
             "star",
             "ellipse",
             "database",
             "text",
             "diamond"
           )[1],
           nodesIdSelection = F, seed = 314) {
    
    if (class(RVM) != "RVineMatrix")
      stop("Object Not RVineMatrix!")
    
    
    if(missing(group) & missing(group.size))
    {
      group <- 1
      group.size <- 1
    } else if(!missing(group) & !missing(group.size))
    {
      if(length(group) != length(group.size) )
        stop("Parameters group and group.size not equal length!")
      
      if(sum(group.size) != length(RVM$names))
        stop("Parameter group.size not well specifed as sum of group size not equal to number variables in RVineMatrix!")
    }
    
    sink(tempfile())
    rvineSummary <- summary(RVM)
    sink()
    
    if (missing(colours)) {
      colours <- colorspace::rainbow_hcl(length(group.size))
    } else {
      if (length(colours) != sum(group.size)) {
        message(
          "Number of colours specified not equal to number of group size, using default colours\n")
        
        print(length(group.size))
        colours <- colorspace::rainbow_hcl(length(group.size))
        print(colours)
      }
    }
    
    if (length(shape) != length(group.size) | length(shape) == 1) {
      shape  <- rep(shape, sum(group.size))
    } else {
      shape <- rep(shape, group.size)
    }
    
    
    
    tau <-
      rvineSummary$tau[nrow(rvineSummary$tau), -ncol(rvineSummary$tau)]
    
    nodes <-
      data.frame(
        id = rvineSummary$names,
        title = rvineSummary$names,
        shape = shape,
        size = 15,
        color = rep(colours, group.size),
        # group  = c(rep("Fin", 4), rep("energy", 4), rep("Ind", 2))
        group  = rep(group, group.size)
      )
    
    from <- diag(RVM$Matrix)[-length(diag(RVM$Matrix))]
    to <- c(tail(RVM$Matrix, 1))[-length(tail(RVM$Matrix, 1))]
    
    
    edges <-
      data.frame(
        from = rvineSummary$names[from],
        to = rvineSummary$names[to],
        value = 3,
        label = round(tau, 2)
      )
    
    if (length(group) != 1)
    {
      x  <- visNetwork(nodes, edges, height = "500px", width = "100%") %>%
        visLegend(
          useGroups = FALSE,
          addNodes = data.frame(
            label = group,
            shape = "circle",
            color = colours, 
            clickToUse = T
          )
        ) %>%
        visOptions(highlightNearest = TRUE, nodesIdSelection = nodesIdSelection) %>%
        visLayout(randomSeed = seed)
    } else {
      x  <- visNetwork(nodes, edges, height = "500px", width = "100%", zoom = 3) %>%
        visOptions(highlightNearest = TRUE, nodesIdSelection = nodesIdSelection) %>%
        visLayout(randomSeed = seed)
    }
    x
    # Save to html
    
    # visSave(x, file = "network.html")
    
  }