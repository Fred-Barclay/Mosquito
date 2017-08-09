# All.R
# Plot all bloodwork numbers and trends on a single graph
library(reshape2)
library(tidyverse)

mainCsv <- file.choose()

FN_2187 <- tail(strsplit(mainCsv, "\\\\")[[1]], 1)

maindata <- read.csv(mainCsv, header = TRUE)

Feats <- melt(maindata, id.vars = c("Date"), variable.name = c("Feature"))

out <- paste0(getwd(), "/Results/")

plttrend <- ggplot(Feats, aes(x = as.Date(Date, "%m%d%y"), y = value, color = Feature), na.rm = TRUE)+
    geom_point()+
    geom_smooth(se = FALSE, method = "loess")+
    xlab("Date")

pltbox <- ggplot(Feats, aes(x = Feature, y = value, color = Feature), na.rm = TRUE)+
    geom_boxplot()+
    coord_flip()+
    theme(legend.position="none")

ggsave(plttrend, file = paste(out, "BW_Trend.png"))
ggsave(pltbox, file = paste(out, "BW_Boxplt.png"))

print(plttrend)
print(pltbox)