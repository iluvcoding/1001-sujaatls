library(ggplot2)

files = Sys.glob('/home/rishu/Projects/1001/sujaatls/inp/*/*.csv')

out.dir = '/home/rishu/Projects/1001/sujaatls/out'

for(f in files)
{
  print(f)
  csv = read.csv(f)
  csv$sm <- csv$sm/100
  csv$index <- NA
  
  dates =as.Date(as.character(as.numeric(csv$Date)),format = "%Y%m%d")
  csv$index[dates  >= as.Date('2016-6-1') & dates  <= as.Date('2016-9-30')] <- 1
  csv$index[dates  >= as.Date('2016-10-1') & dates  <= as.Date('2017-1-31')] <- 2
  csv$index[dates  >= as.Date('2017-6-1') & dates  <= as.Date('2017-9-30')] <- 3
  csv$index[dates  >= as.Date('2017-10-1') & dates  <= as.Date('2018-1-31')] <- 4
  csv$index[dates  >= as.Date('2018-6-1') & dates  <= as.Date('2018-9-30')] <- 5
  csv$index[dates  >= as.Date('2018-10-1') & dates  <= as.Date('2019-1-1')] <- 6
  averages = aggregate(csv$sm, by = list(csv$index), FUN = 'mean', na.rm = T)
  if(length(averages$Group.1)< 6){
    if(sum(averages$Group.1 == 1) == 0){
      averages[length(averages$Group.1)+1,] <- c(1, 0)
    }
    if(sum(averages$Group.1 == 2) == 0){
      averages[length(averages$Group.1)+1,] <- c(2, 0)
    }
    if(sum(averages$Group.1 == 3) == 0){
      averages[length(averages$Group.1)+1,] <- c(3, 0)
    }
    if(sum(averages$Group.1 == 4) == 0){
      averages[length(averages$Group.1)+1,] <- c(4, 0)
    }
    if(sum(averages$Group.1 == 5) == 0){
      averages[length(averages$Group.1)+1,] <- c(5, 0)
    }
    if(sum(averages$Group.1 == 6) == 0){
      averages[length(averages$Group.1)+1,] <- c(6, 0)
    }
    
  }
  theme_set(theme_gray(base_size = 18))
  g <- ggplot()
  
  g <- g + geom_col(aes(x = 1:6, y=averages$x), fill = 'blue')
  g <- g +  scale_x_continuous(label = c('Kharif\n2016', 'Rabi\n2016/17', 'Kharif\n2017', 
                                         'Rabi\n2017/18', 'Kharif\n2018', 'Rabi\n2018/19'),
                               breaks = c(1:6), name = "Seasons")
  g <- g + scale_y_continuous(label = c('0.0', '0.1', '0.2', '0.3', '0.4', '0.5' ), breaks = c(0:0.5))
  g <- g + ylab(expression(paste("Soil moisture (",m^3, "/", m^3,")", sep="")))
  
  print(g)
  
  
  b = basename(f)
  out = gsub(pattern = ".csv", replacement = ".png", b)
  
  out_file = paste(out.dir, out, sep = "/")
  
  ggsave(out_file)
  print(f)
  print(out_file)
  
  
}





