theme_set(theme_gray(base_size = 18))
  g <- ggplot(df)
  g <- g + geom_line(aes(x = date, y = udaviR::swi_fun(rsm, 7)), color = 'blue')
  g <- g + ylim(0,0.4)
  g <- g + xlab('Date')
  g <- g + ylab(expression(paste("Soil moisture (",m^3, "/", m^3,")", sep="")))
  g <- g + scale_x_date(date_labels = '%b\n%Y', limits=c(as.Date('2015-10-01'),
                                                         as.Date('2018-09-30')), date_breaks = '4 month')
  # g + scale_x_date(date_labels = '%b\n%Y', limits=c(as.Date('2015-10-01'),
  #                                                        as.Date('2018-05-30')), date_breaks = '4 month')
  # g <- g + scale_x_date(date_labels = '%b\n%Y', limits=c(as.Date('2016-02-01'), 
  #                                                        as.Date('2018-02-28')), date_breaks = '4 month')
  #shp.name <- gsub('.csv', '', basename(shp.file))
  out.name <- file.path(dir.fig, sprintf("%s.png",file_path_sans_ext(basename(file.shp))))
  # g <- g + ggtitle(out.name)
  print(g)
  ggsave(out.name)
