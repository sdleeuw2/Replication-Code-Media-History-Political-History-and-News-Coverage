
# directory Github code
location_folder = "/Users/sjifradeleeuw/GitHub/" # change location

# directories
data_dir = paste0(location_folder, "Replication-Code-Media-History-Political-History-and-News-Coverage/Data/") # do not change
fig_dir = paste0(location_folder, "Replication-Code-Media-History-Political-History-and-News-Coverage/Output/Figures/") # do not change
tab_dir = paste0(location_folder, "Replication-Code-Media-History-Political-History-and-News-Coverage/Output/Tables/") # do not change
workspace_dir = paste0(location_folder, "Replication-Code-Media-History-Political-History-and-News-Coverage/Workspace/")

# import data
df = read.csv(paste0(data_dir, "trump_dataset.csv"))

# dependent variable
df$pej = 0; df$pej[df$pej_antidem == 1] = 1; df$pej[df$pej_cont == 1] = 1;
df$pej[df$pej_hist == 1] = 1; df$pej[df$pej_ill == 1] = 1

# measurement levels
df$outlet = factor(df$outlet)
df$prof_trad = factor(df$prof_trad); df$prof_trad = factor(df$prof_trad ,levels(df$prof_trad)[c(2,3,1)])
df$partrad = factor(df$parttrad); df$partrad = factor(df$partrad,levels(df$partrad)[c(2,3,1)])
df$lr = factor(df$lr); df$lr = factor(df$lr ,levels(df$lr)[c(2,3,1)])
df$lr_b = df$lr; df$lr_b[df$lr=="center"] = NA
df$length = as.numeric(df$length)
df$date = as.Date(paste0(df$year, "-", df$month, "-", df$day), format = "%Y-%b-%d")
df$outletyear = paste0(df$outlet, df$year)
df = subset(df, date > "2016-06-15")

# aggregated dataset
pej = aggregate(pej ~ country, data = df, FUN = mean)
pej$country = as.character(pej$country)

# rescale length 
df$length = df$length - min(df$length, na.rm = TRUE)
df$length = df$length / max(df$length, na.rm = TRUE)