var express = require('express');
var router = express.Router();
const newsletter = require('../controllers/newsletter.js');


router.get('/', function (req, res) {
    res.render('index', {
        title: 'RChain',
        style: 'index',
        ogtitle: 'RChain',
        ogdescription: "",
        ogurl: 'https://rchain.coop/',
        ogimg: '',
        scripts: '/js/homepage_Browser.js'
    });
});


router.get('/get-started', function (req, res) {
    res.render('get-started', {
        title: 'get-started',
        style: 'get-started',
        ogtitle: 'RChain',
        ogdescription: "",
        ogurl: 'https://rchain.coop/get-started',
        ogimg: '',
        scripts: '/js/get-started_Browser.js'
    });
});

router.get('/platform', function (req, res) {
    res.render('platform', {
        title: 'rchain platform',
        style: 'platform',
        ogtitle: 'rchain platform',
        ogdescription: "",
        ogurl: 'https://rchain.coop/platform',
        ogimg: '',
        scripts: ''
    });
});

router.get('/learn-rholang', function (req, res) {
    res.render('learn-rholang', {
        title: 'Learn Rholang',
        style: 'learn-rholang',
        ogtitle: 'Learn Rholang',
        ogdescription: "",
        ogurl: 'https://rchain.coop/platform',
        ogimg: '',
        scripts: '/js/learn-rholang_Browser.js'
    });
});

router.get('/community', function (req, res) {
    res.render('community', {
        title: 'RChain Community',
        style: 'community',
        ogtitle: 'RChain Community',
        ogdescription: "",
        ogurl: 'https://rchain.coop/community',
        ogimg: '',
        scripts: ''
    });
});

router.get('/team', function (req, res) {
    res.render('team', {
        title: 'RChain Team',
        style: 'team',
        ogtitle: 'RChain Team',
        ogdescription: "",
        ogurl: 'https://rchain.coop/team',
        ogimg: '',
        scripts: ''
    });
});

router.get('/rnode-install', function (req, res) {
    res.render('rnode-install', {
        title: 'Install RNode',
        style: 'rnode-install',
        ogtitle: 'Install RNode',
        ogdescription: "",
        ogurl: 'https://rchain.coop/rnode-install',
        ogimg: '',
        scripts: '/js/rnode-install_Browser.js'
    });
});

router.get('/portfolio', function (req, res) {
    res.render('portfolio', {
        title: 'Portfolio',
        style: 'portfolio',
        ogtitle: 'Portfolio',
        ogdescription: "",
        ogurl: 'https://rchain.coop/portfolio',
        ogimg: ''
    });
});

router.get('/events', function (req, res) {
    res.redirect('https://developer.rchain.coop/conference');
});

router.get('/blog',  (req, res, next) => {  
    res.redirect(301, 'https://blog.rchain.coop/');
});

/* POST Newsletter signup. */
router.post('/newsletter-submission', function (req, res) {
    var success = ["success"];
    var errors = newsletter.formValidation(req);
    if (req.validationErrors()) {
        res.send(errors);
    } else {
        newsletter.saveSubmission(req);
        res.send(success);
    }
});

router.get('*', function(req, res, next) {
  let err = new Error(`${req.ip} tried to reach ${req.originalUrl}`); // Tells us which IP tried to reach a particular URL
  err.statusCode = 404;
  err.shouldRedirect = true; //New property on err so that our middleware will redirect
  next(err);
});

module.exports = router;
