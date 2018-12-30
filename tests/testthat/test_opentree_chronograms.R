test_that("get_otol_chronograms works", {
	# skip_on_cran()
  #	skip_on_travis() #b/c no pathd8
  # skip_on_os("linux") #b/c no pathd8 on travis linux

  utils::data(opentree_chronograms)
  xx <- get_otol_chronograms(verbose=TRUE, max_tree_count = 10)
  # test that the following makes sense:
  # tree.id = 'tree1'
  # study.id = 'ot_1000'
  # new.tree <- rotl::get_study_tree(study_id=study.id,tree_id=tree.id, tip_label="ott_taxon_name") #would like to dedup; don't use get_study_subtree, as right now it doesn't take tip_label args
  # try.tree <- clean_ott_chronogram(new.tree)
  # data.frame(new.tree$tip.label, try.tree$tip.label)
  # is_good_chronogram(try.tree)
  # class(try.tree)
  # inherits(try.tree, "phylo")
})

test_that("is_good_chronogram works as expected", {
  utils::data(felid_gdr_phylo_all)
  t1 <- felid_gdr_phylo_all$phylo_all[[1]]
  expect_true(is_good_chronogram(t1))
  # test that there are al types of not.mapped are detected:
  t1$tip.label[1] <-  "*tip_#1_not_mapped_to_OTT._Original_label_-_Hagensia_havilandi"
  t1$tip.label[2] <-  "*tip_#1_not_mapped_to_OTT._Original_label_-_Felis_silvestris"
  expect_false(is_good_chronogram(t1))
  t2 <- t1
  t2$tip.label <- gsub("_", " ", t1$tip.label)
  expect_false(is_good_chronogram(t2))
  # enhance: test that there are no duplicated labels:
  t1$tip.label[4] <-  "*tip_#1_not_mapped_to_OTT._Original_label_-_Hagensia_havilandi"
  # is_good_chronogram(t1)

})

test_that("clean_ott_chronogram works as expected", {
  # enhance: there's something wrong when trying to clean the following tree:
  new.tree2 <- rotl::get_study_tree(study_id = "ot_1041", tree_id = "tree1", tip_label = "ott_id")
  # clean_ott_chronogram(new.tree2)
})

test_that("opentree_chronograms object is ok", {
  utils::data(opentree_chronograms)
  # write(paste(names(opentree_chronograms), collapse = '", "'), file = "data-raw/names.txt")
  # test that all expected elements are in opentree_chronograms:
  expect_true(all(c("trees", "authors", "curators", "studies", "dois") %in% names(opentree_chronograms)))
  # test that all opentree_chronograms elements have the same length:
  expect_true(all(sapply(opentree_chronograms, length) == length(opentree_chronograms$trees)))
  # opentree_chronograms$trees
})