function initCond = initCond_save(bubbleInit, airgunInit)

initCond = [bubbleInit.R, bubbleInit.U, bubbleInit.m, bubbleInit.T,...
    airgunInit.p, airgunInit.m];