import { CacheGithub } from "../fetch/cache.js"
import { userName } from "../fetch/getUserName.js";

function main() {
  const cache = new CacheGithub();
  const keyCache = `user${userName}@portifio-challenge`
  const cacheData = cache.getCache(keyCache);
  if (cacheData) {
    console.log(JSON.parse(cacheData))
  }

}
main()