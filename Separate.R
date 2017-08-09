# Separate.R
# Plot all features, but separate graphs for each
library(reshape2)
library(ggplot2)

mainCsv <- file.choose()

FN_2187 <- tail(strsplit(mainCsv, "\\\\")[[1]], 1)

maindata <- read.csv(mainCsv, header = TRUE)

Feats <- melt(maindata, id.vars = c("Date"), variable.name = c("Feature"))

out <- paste0(getwd(), "/Results/")

for (i in levels(Feats$Feature)){
    # Build a subset for each type of count (White cell, MMA, etc)
    type <- subset(Feats, Feature == i)

    plt <- ggplot(data = type, aes(x = as.Date(Date, "%m%d%y"), y = value), na.rm = TRUE)+
        geom_point()+
        geom_smooth(se = FALSE)+
        xlab("Date")+
        ylab(type$Feat[1])

    ggsave(plt, file = paste0(out, type$Feature[1], ".png"))
}