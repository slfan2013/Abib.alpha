pacman::p_load(pathview)
data(gse16873.d)
pv.out <- pathview(gene.data = gse16873.d[, 1], pathway.id = "04110",
                  species = "hsa", out.suffix = "gse16873")
data(demo.paths)

sim.cpd.data=sim.mol.data(mol.type="cpd", nmol=3000)
sim.cpd.data2 = matrix(sample(sim.cpd.data, 18000,replace = T), ncol = 6)



pathview(gene.data = gse16873.d[, 1], pathway.id = "01100",
         species = "hsa", out.suffix = "")


pv.out <- pathview(gene.data = gse16873.d[, 1:3],
                  cpd.data = sim.cpd.data2[, 1:2], pathway.id = demo.paths$sel.paths[1],
                  species = "hsa", out.suffix = "gse16873.cpd.3-2s", keys.align = "y",
                  kegg.native = T, match.data = F, multi.state = T, same.layer = T)
head(pv.out$plot.data.cpd)



set.seed(10)
sim.cpd.data=sim.mol.data(mol.type="cpd", nmol=1000)
sim.cpd.data2 = matrix(sample(sim.cpd.data, 180,
                              replace = T), ncol = 6)
rownames(sim.cpd.data2) = names(sim.cpd.data)[1:nrow(sim.cpd.data2)]

colnames(sim.cpd.data2) = paste("exp", 1:6, sep = "")
pv.out <- pathview(cpd.data = sim.cpd.data2[, 1:2], pathway.id = "01100")
