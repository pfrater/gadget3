
## all age reading before 1999 are omitted

## weird inconsistencies in Gadget
aldist.igfs[[1]]$step <- 2
ldist.igfs[[1]]$step <- 2
matp.igfs[[1]]$step <- 2

nll_breakdown <- TRUE  # Turn to TRUE to get per-step nll
lik_report <- TRUE

ling_likelihood_actions <- list(
  g3l_understocking(list(ling_imm, ling_mat), nll_breakdown = nll_breakdown, weight = 1e6),

  g3l_catchdistribution(
    'ldist_lln',
    weight = ~g3_param('ldist_lln_weight'),#3331,
    ldist.lln[[1]] %>% ## tow == 60228 was wrongly assigned, omit samples from that quarter
      filter(!(year==1993&step==4)),
    fleets = list(lln),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_sumofsquares(),
    nll_breakdown = nll_breakdown,
    report = lik_report),
  g3l_catchdistribution(
    'aldist_lln',
    weight = ~g3_param('aldist_lln_weight'),#2512,
    aldist.lln[[1]] %>%  ## only 20 fish aged taken in those quarters
      filter(year>1998,!((year==2002|year==2003)&step==2)),
    fleets = list(lln),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_sumofsquares(),
    nll_breakdown = nll_breakdown,
    report = lik_report),
  g3l_catchdistribution(
    'ldist_bmt',
    weight = ~g3_param('ldist_bmt_weight'),#1247,
    (ldist.bmt[[1]]) %>% ## to few samples (<=20 fish lengths)
      filter(!(year==1982&step==4),
             !(year==1984&step==1),
             !(year==1992&step==4),
             !(year==1994&step==1),
             !(year==1998&step==3),
             !(year==1989&step==3)),
    fleets = list(bmt),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_sumofsquares(),
    nll_breakdown = nll_breakdown,     report = lik_report),
  g3l_catchdistribution(
    'aldist_bmt',
    weight = ~g3_param('aldist_bmt_weight'),#1515,
    (aldist.bmt[[1]]) %>%
      filter(year>1998),
    fleets = list(bmt),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_sumofsquares(),
    nll_breakdown = nll_breakdown,     report = lik_report),
  g3l_catchdistribution(
    'ldist_gil',
    weight = ~g3_param('ldist_gil_weight'),#781,
    (ldist.gil[[1]]) %>% ## only one fish lengthmeasured
      filter(!(year==2005&step==2)),
    fleets = list(gil),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_sumofsquares(),
    nll_breakdown = nll_breakdown,     report = lik_report),
  g3l_catchdistribution(
    'aldist_gil',
    weight = ~g3_param('aldist_gil_weight'),#719,
    (aldist.gil[[1]]) %>%
      filter(year>1998),
    fleets = list(gil),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_sumofsquares(),
    nll_breakdown = nll_breakdown,     report = lik_report),
  g3l_catchdistribution(
    'ldist_igfs',
    weight = ~g3_param('ldist_igfs_weight'),#6869,
    (ldist.igfs[[1]]),
    fleets = list(igfs),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_sumofsquares(),
    nll_breakdown = nll_breakdown,     report = lik_report),
  g3l_catchdistribution(
    'aldist_igfs',
    weight = ~g3_param('aldist_igfs_weight'),#11087,
    (aldist.igfs[[1]]) %>% ## only two age samples in 1989
      filter(year>1998),
    fleets = list(igfs),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_sumofsquares(),
    nll_breakdown = nll_breakdown,     report = lik_report),
  g3l_catchdistribution(
    'matp_igfs',
    weight = ~g3_param('matp_igfs_weight'),#9,
    (matp.igfs[[1]] %>%
      rename(stock = maturity_stage) %>%
      mutate(stock = recode(as.factor(stock), lingimm = "ling_imm", lingmat = "ling_mat"))),
    fleets = list(igfs),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_sumofsquares(),
    nll_breakdown = nll_breakdown,     report = lik_report),
  g3l_distribution(
    'si_igfs_si1',
    weight = ~g3_param('si_igfs_si1_weight'),#40,
    (igfs.SI1[[1]]),
    fleets = list(),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_surveyindices_log(alpha = ~g3_param('ling_si_alpha1'),
                                            beta = ~g3_param('ling_si_beta1')),
    nll_breakdown = nll_breakdown,     report = lik_report),
  g3l_distribution(
    'si_igfs_si2a',
    weight = ~g3_param('si_igfs_si2a_weight'),#8,
    (igfs.SI2a[[1]]),
    fleets = list(),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_surveyindices_log(alpha = ~g3_param('ling_si_alpha2'),
                                            beta = ~g3_param('ling_si_beta2')),
    nll_breakdown = nll_breakdown,     report = lik_report),
  g3l_distribution(
    'si_igfs_si2b',
    weight = ~g3_param('si_igfs_si2b_weight'),#36,
    (igfs.SI2b[[1]]),
    fleets = list(),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_surveyindices_log(alpha = ~g3_param('ling_si_alpha3'),
                                            beta = 1),
    nll_breakdown = nll_breakdown,     report = lik_report),
  g3l_distribution(
    'si_igfs_si3a',
    weight = ~g3_param('si_igfs_si3a_weight'),
    (igfs.SI3a[[1]]),
    fleets = list(),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_surveyindices_log(alpha = ~g3_param('ling_si_alpha4'),
                                            beta = 1),
    nll_breakdown = nll_breakdown,     report = lik_report),
  g3l_distribution(
    'si_igfs_si3b',
    weight = ~g3_param('si_igfs_si3b_weight'),#19,
    (igfs.SI3b[[1]]),
    fleets = list(),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_surveyindices_log(alpha = ~g3_param('ling_si_alpha5'),
                                            beta = 1),
    nll_breakdown = nll_breakdown,     report = lik_report),
  g3l_distribution(
    'si_igfs_si3c',
    weight = ~g3_param('si_igfs_si3c_weight'),#16,
    (igfs.SI3b[[1]]),
    fleets = list(),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_surveyindices_log(alpha = ~g3_param('ling_si_alpha6'),
                                            beta = 1),
    nll_breakdown = nll_breakdown,     report = lik_report),
  g3l_distribution(
    'si_igfs_si3d',
    weight = ~g3_param('si_igfs_si3d_weight'),#13,
    (igfs.SI3d[[1]]),
    fleets = list(),
    stocks = list(ling_imm, ling_mat),
    g3l_distribution_surveyindices_log(alpha = ~g3_param('ling_si_alpha7'),
                                            beta = 1),
    nll_breakdown = nll_breakdown,     report = lik_report),
  list()
)
