'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "6fff3cdc0b3ee30cc1136d5a554b1def",
".git/config": "f13aaf906298aca5beba93ce6c2f4c0c",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "87cb5aba172cbc3723f24b16328f0f32",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "d46649720fd666cbd47c96345eaacdc4",
".git/logs/refs/heads/gh-pages": "d46649720fd666cbd47c96345eaacdc4",
".git/logs/refs/remotes/origin/gh-pages": "737cd41f1114296123dbbe7fdfe02fe2",
".git/objects/04/ad1deb7fc03c58cea20909b53319a5fee3b669": "2eed6376da21bb66775e111dcc349032",
".git/objects/08/27c17254fd3959af211aaf91a82d3b9a804c2f": "360dc8df65dabbf4e7f858711c46cc09",
".git/objects/0c/f89720f288ace4ad1a3c95f9d73bfe2c3846a1": "8820b50c252bed4c418c524ac6093953",
".git/objects/14/44668d2aff3d01d1c844760faa1aa108472d49": "ed979e333cfec4479ae931c006eb3a5b",
".git/objects/15/f04fd744a17c257dac2486ea823a29f7f9c230": "00eec6e4eb2443d4066bd9634c3439bf",
".git/objects/16/6f22c3cf87add08276f358c56efe760f5349c0": "ffe4c7317659218dcfa53a178327efd3",
".git/objects/1b/9f951e65655287198a27ef33acb8c03d18781f": "d8a3974fb143358ecadc362a4ed6ac6f",
".git/objects/21/fb556d0d0fe38985dbf54efaf6cdf9106adf5f": "4013895d122f8fc9acfa015fa650e25f",
".git/objects/26/eebd5049967e3e0be1eb50b603b18b5afceb99": "6071b11c1c1dbc112324e0e011d20dde",
".git/objects/2a/776534d7e192f2e443e43915ea842ff31a601e": "5521f187b7f0e080eef87ba18ac4ac27",
".git/objects/34/2959a77861cf23a87d9f2e1a381c159dde083a": "36426a7e853cf1d0fc00cba461be022a",
".git/objects/34/a721e5a2284929bd0e166c91b965c337a09dc9": "61d010d39a4832638aec224caa132534",
".git/objects/34/c34d97d4fac8ffda58be7167042ea89357c58a": "2e748ff044fb6e2e697bd795b12aedbd",
".git/objects/3a/8cda5335b4b2a108123194b84df133bac91b23": "1636ee51263ed072c69e4e3b8d14f339",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/4e/8a582247139dbebdeb637c7697a237a791b960": "44081c4b10bcf4a260db90c06e7d17b8",
".git/objects/51/03e757c71f2abfd2269054a790f775ec61ffa4": "d437b77e41df8fcc0c0e99f143adc093",
".git/objects/53/0062bd004c6cebeb92b515e60f284be6a74407": "6313b41e6762385ed538e6d687bdd1f3",
".git/objects/54/d9faa994ea09abe89dd0a6227a8bea6b60b232": "294075738c68f90be6ce70780ab058ce",
".git/objects/55/0d4f7ef7f8b6fdef4e2a74de7ce7c26d8cee54": "8b8e35efaa0a4f1beb6605d1b046bc26",
".git/objects/55/87262c7acdb398810e04c680501b7433db92c1": "c88b08cf33f4df44ee3636fd72254926",
".git/objects/57/235843e4ff5b0da60a61fc08c74b2532ba0725": "db1a1e11b8954d88719e7e195b7b97b7",
".git/objects/5c/fa728421e381b4f841a3dfd846e3dc703c3e5f": "7bc32d5eb970b262f806b2b308df0c48",
".git/objects/5d/a99c1e3d222d5805e78530163210a766ba7939": "930aee92791e57c449c9442a11fa0f47",
".git/objects/5f/5ddd4a51b8eaf44d5603bd12e12da960dffb92": "bdb108912abef0285f41e32c2706530d",
".git/objects/66/97bdb30958d302995c1a499d128d9a31d092fa": "09b2671c281e86a6a6a11efff3415d09",
".git/objects/68/43fddc6aef172d5576ecce56160b1c73bc0f85": "2a91c358adf65703ab820ee54e7aff37",
".git/objects/6f/7661bc79baa113f478e9a717e0c4959a3f3d27": "985be3a6935e9d31febd5205a9e04c4e",
".git/objects/73/9cfce039b6c50945ae7ed7357ffbfc169f0303": "8b250ad794f0278ea58898ba2473ba50",
".git/objects/75/7440ad88ecf3cfe405845e8c6f3fef09c2c7f0": "1b3f53a831afad196c04271c6082079d",
".git/objects/7a/c08c8c7510096074e9736b3b2bbdf2f8c6be0c": "7ba4299bc76eb8eeaa5d7a682eafc430",
".git/objects/7c/3463b788d022128d17b29072564326f1fd8819": "37fee507a59e935fc85169a822943ba2",
".git/objects/83/90d49e4adbd5ae88027383b5b41d164330e1db": "f57590f18770a27f3187e2980bb972ec",
".git/objects/84/d52fd008077b689139d9e340fee6c64f52e13a": "e8eb610635facbebffa77645c44f6068",
".git/objects/85/63aed2175379d2e75ec05ec0373a302730b6ad": "997f96db42b2dde7c208b10d023a5a8e",
".git/objects/8e/21753cdb204192a414b235db41da6a8446c8b4": "1e467e19cabb5d3d38b8fe200c37479e",
".git/objects/90/c7376080e8b5715da86f2c27f7c638c886523b": "5a3ab183cbff7ecbcfc9b42b9cdcd1f0",
".git/objects/91/3206cfe53c3e9ab1f03b3abea0b4935a26a143": "3d4a1451fd817ec2cf0725da8ff5c032",
".git/objects/91/b62ec11c15a2e40e7e532bbc1c4b0ba2c042ef": "33822cc5f7d989c4b0c3c80a952bf5d6",
".git/objects/93/b363f37b4951e6c5b9e1932ed169c9928b1e90": "c8d74fb3083c0dc39be8cff78a1d4dd5",
".git/objects/99/dea97b678af159e8958bd5cc923741127af642": "8a8bd3faec48203a486ff6a7349a43cd",
".git/objects/9f/ca6eb029f215e7d23329c661f9ebc47f478b74": "986cabe726d82be8749bb8858f3bffd1",
".git/objects/a1/dd332d4acaf01c47e8a8c6fa824a4692532039": "393a16f5ce17ff2d8ccff6aca73096cb",
".git/objects/a7/3f4b23dde68ce5a05ce4c658ccd690c7f707ec": "ee275830276a88bac752feff80ed6470",
".git/objects/ac/27a1a20587246c19950bbe69100bbbdcfda761": "042004fb5d65d3673e8e5890975fa074",
".git/objects/ad/ced61befd6b9d30829511317b07b72e66918a1": "37e7fcca73f0b6930673b256fac467ae",
".git/objects/b0/264b927fff94529b6551b62938f1b4e6636642": "f42293b035f9e23ceeb37f358c272703",
".git/objects/b8/ad146eb070644fff415ca9c228d2356c055c50": "2d564b97e0bec1870cc77c2e83ffd395",
".git/objects/b9/3e39bd49dfaf9e225bb598cd9644f833badd9a": "666b0d595ebbcc37f0c7b61220c18864",
".git/objects/bc/3998f3add1026c736c9d9e883f84547ca9d2bf": "b19de0219c9cbdafc397fdd7a37a1617",
".git/objects/bc/919f35356827f1247efebb99ba5c88f0fc93c6": "b89c4255710433628daadc3ba698a60b",
".git/objects/c8/3af99da428c63c1f82efdcd11c8d5297bddb04": "144ef6d9a8ff9a753d6e3b9573d5242f",
".git/objects/c9/53eb48dcb28772ad8608178a7246c2587a6f46": "62a7ebe9bbea28a91c475d8e904c7902",
".git/objects/cf/f6aafb3d15c0557c161e41b87184245702c751": "60a3177f1d0165016e269a37a1c86732",
".git/objects/d0/7ccb1d45bebf4f92d4dd75f8dfabf17e714604": "96d38d12e920a7084a1f27608cfc3788",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d9/5b1d3499b3b3d3989fa2a461151ba2abd92a07": "a072a09ac2efe43c8d49b7356317e52e",
".git/objects/de/6a77f8b5550699fe41a494189d8ee3e05f9032": "383e3454bbd760dbc7e722f380491add",
".git/objects/e2/19193a20f5261877e3112c78a21e32314d33d4": "24207c26309310713e9ee1417947f9e8",
".git/objects/e5/62bf9957855e642c7484d21f89da1a28af3231": "48e65c427d6fd2ad440a8175ca464d2d",
".git/objects/e8/2dbfb1e6f9026860d59d09a308d85868d3b8a2": "88ecfddeaf3d126e1c402eeba5c31ffe",
".git/objects/ea/640fed09afcac0ac5fa9c7b196ab498ce96c45": "97edafefa6808f45ed6772068877a166",
".git/objects/f0/1fbddfc023c28ba8920b8296f7d4bc83446a09": "6d51f7e46d9cf8bb42a4dccd1d2fc684",
".git/objects/f1/b4c91473f2a301828e431ff5ce0dec04e063f3": "f17435631768ad072e33860cd46dd60e",
".git/objects/f3/156b3ab623ee32776e70a135a14e74187e8910": "d6d1fd19502cef425a86d31563c9433a",
".git/objects/f3/3e0726c3581f96c51f862cf61120af36599a32": "afcaefd94c5f13d3da610e0defa27e50",
".git/objects/f4/23ee26de6a9e24c91a4b2410d041b8d2a33172": "12aa1a9eeb58bcd5802d8c96bd52a1c8",
".git/objects/f6/e6c75d6f1151eeb165a90f04b4d99effa41e83": "95ea83d65d44e4c524c6d51286406ac8",
".git/objects/fd/05cfbc927a4fedcbe4d6d4b62e2c1ed8918f26": "5675c69555d005a1a244cc8ba90a402c",
".git/objects/fe/76b9b6652182db66b320eb26b3d2931fb77235": "29150685495cb94de37edf052f3d0a74",
".git/refs/heads/gh-pages": "9042abe7f9f51dc60ee79c124c1fec5a",
".git/refs/remotes/origin/gh-pages": "9042abe7f9f51dc60ee79c124c1fec5a",
"assets/AssetManifest.bin": "c259ab0a0505e0ba89b6aa1313d73303",
"assets/AssetManifest.bin.json": "f199863b233370a1222fca4bdb2fa913",
"assets/assets/icon/app_icon.png": "86cd92cd214b93297262146f1984f4e9",
"assets/assets/icon/splash.png": "86cd92cd214b93297262146f1984f4e9",
"assets/assets/images/connect-device.png": "e11f1f23fc5d62d2dc303208a5cb7c21",
"assets/assets/images/home_filled.png": "13135c638c510ba692aaeb54e3ae244a",
"assets/assets/images/home_unfilled.png": "85f48257bfe8c7f0e40a8d3a9f322c84",
"assets/assets/images/library.png": "bf9ad2864ecdcde170a870f548e88c90",
"assets/assets/images/next-audio.png": "ece95f33dde5cf64c415e3bb3c37b845",
"assets/assets/images/playlist.png": "6e3d4be1f8933d6281f9300522d4f619",
"assets/assets/images/previous-audio.png": "aa023fe5e9da038a560bb048317cc3d3",
"assets/assets/images/pull-down-arrow.png": "36b39c782b2110b6ed278f46f8a64618",
"assets/assets/images/repeat.png": "7eea6f1acb46f85b239ce02db7f5d021",
"assets/assets/images/search_filled.png": "46fd473d3b2ebe93d18867d2b54eb75f",
"assets/assets/images/search_unfilled.png": "4a9e8938ae506b7eda565d6e00bb8b48",
"assets/assets/images/shuffle.png": "e9972a99e84efd86149d2a5f6a298b53",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "0e3e9a4d89bcb50541597aa3040f832c",
"assets/NOTICES": "5452128b50aa301c38622dd687c75299",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "54af874597c81da51a7d5294696de2f6",
"assets/packages/flex_color_picker/assets/opacity.png": "49c4f3bcb1b25364bb4c255edcaaf5b2",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "ca680b4af5500d682cf38261cb682025",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "6c7d11d1715950566299e63bdee1af4b",
"icons/Icon-192.png": "741e4d6fb277d282e26c34b9347b7159",
"icons/Icon-512.png": "ea6ee5832010c6762715247d6244b3dc",
"icons/Icon-maskable-192.png": "741e4d6fb277d282e26c34b9347b7159",
"icons/Icon-maskable-512.png": "ea6ee5832010c6762715247d6244b3dc",
"index.html": "73abd25e664161b7fcb3479b3c2d63e2",
"/": "73abd25e664161b7fcb3479b3c2d63e2",
"main.dart.js": "a9133342650bd56728af83aa843dac9d",
"manifest.json": "13367335e66dcc3189b638b446bdd53e",
"splash/img/dark-1x.png": "1355e646593692b287e456b98afcfc52",
"splash/img/dark-2x.png": "9d1a0f3fef172722b6eb12f278ed5f6a",
"splash/img/dark-3x.png": "093b195b596d32f2e0a222771e619cfc",
"splash/img/dark-4x.png": "2a9c23487f02684442437be3d10ed018",
"splash/img/light-1x.png": "1355e646593692b287e456b98afcfc52",
"splash/img/light-2x.png": "9d1a0f3fef172722b6eb12f278ed5f6a",
"splash/img/light-3x.png": "093b195b596d32f2e0a222771e619cfc",
"splash/img/light-4x.png": "2a9c23487f02684442437be3d10ed018",
"version.json": "c6257a6b73115bffd54409abf919e69a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
