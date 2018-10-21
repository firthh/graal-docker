(ns server.handler
  (:require [clojure.java.io :as io]
            [clojure.data.json :as json]
            [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]))

(def json-file
  (slurp (io/resource "file.json")))

(defn parse-file []
  (json/read-str json-file :key-fn keyword))

(defn work
  "Do some work, both cpu and memory intensive"
  [size]
  (->> (range size)
       (map (fn [_] (parse-file)))
       (map (fn [obj] (assoc obj :about-count (count (:about obj)))))
       (map :longitude)
       (map (partial + (rand-int 100)))
       (map (fn [long] (/ long 2)))
       (reduce +)))

(defroutes app-routes
  (GET "/" [] "Hello World")
  (GET "/work/:size" [size] (str (work (Integer/parseInt size))))
  (route/not-found "Not Found"))

(def app
  (wrap-defaults app-routes site-defaults))
