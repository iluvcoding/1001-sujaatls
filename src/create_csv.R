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
  
  averages$Group.1 = c('Kharif-2016', 'Rabi-2016/17', 'Kharif-2017', 
                       'Rabi-2017/18', 'Kharif-2018', 'Rabi-2018/19')
  
  colnames(averages) <- c('Seasons', 'Soil Moisture')
  
  print(averages)
  
}