# 创建
PUT /my-index
POST /my-index/_doc
{ "id": "park_rocky-mountain",
  "title": "Rocky Mountain",
  "description": "Bisected north to south by the Continental Divide, this portion of the Rockies has ecosystems varying from over 150 riparian lakes to montane and subalpine."}
PUT /my-index/_doc/0
{ "name":"张三",
  "sex": 1,
  "age": 25,
  "address":"广州华南碧桂园",
  "国家": "中华人民共和国（the People's Republic of China）",
  "爱好": ["唱歌","跳舞","rap","篮球"],
  "remark":"IT"}
POST /_bulk
{"index" : { "_index" : "my-index", "_id" : "1" }}
{"id":"_bulk1", "title" : "批量插入1", "description" : "Bisected north to south by..."}
{"index" : { "_index" : "my-index", "_id" : "2"}}
{ "id":"_bulk2" , "title" : "批量插入2", "description" : "A system of mountains in easter..." }
# 删除
DELETE /my-index/_doc/2
DELETE /my-index
# 查询
HEAD /my-index
GET /_sql?format=txt
{"query": "SHOW TABLES"}
GET /_sql?
{"query": "SELECT*FROM\"my-index\""}
GET /my-index/_search
{"query": {"match_all": {}}}
GET /my-index/_search?q="ROCKY mountain"
POST /my-index/_search
{"query": {"match": {"title": "rocky mountain"}}}
GET /my-index/_search
{"query": {"match": {"title": "插入"}}}
GET /my-index/_search
{"query": {"match": {"description": "riparian"}}}
# 修改
POST /my-index/_update/1
{"doc": {"description": "Updated description of the Rocky Mountain."}}
POST /my-index/_update_by_query
{"query": {"match": {"_id": 0}},"script":{"source": "ctx._source.name='李四'"}}

# 分词 更改需要先关闭index
GET /_cat/plugins?v
POST /my-index/_close
POST /my-index/_open
PUT /my-index/_settings
{"analysis.analyzer.default.type":"icu_analyzer"}
GET /my-index/_analyze
{"text": "中华人民共和国（the People's Republic of China）"}
GET _analyze
{"analyzer":"ik_max_word","text":"中华人民共和国（the People's Republic of China）"}
GET _analyze
{"analyzer":"ik_smart","text":"中华人民共和国（the People's Republic of China）"}
GET _analyze
{"analyzer":"smartcn","text":"中华人民共和国（the People's Republic of China）"}
PUT /new-icu-index
{"settings": {"analysis": {"analyzer": {"default": {"type": "icu_analyzer"}}}}}
GET /new-icu-index/_analyze
{"text": "中华人民共和国（the People's Republic of China）"}
# 复杂查询
GET /my-index/_search
{
  "query": {"match_all": {}},
  "size": 20,
  "from": 9981
}
GET /my-index/_search?scroll=1m
{
  "query": {"match_all": {}},
  "size": 1
}
GET /_search/scroll
{
  "scroll": "1m",
  "scroll_id":"FGluY2x1ZGVfY29udGV4dF91dWlkDXF1ZXJ5QW5kRmV0Y2gBFnZPWk83NjBmUm9LTXEzRFpkdGppRncAAAAAAAAZXhZWZjgyR1ZpYVJ6Njk5UFBQT0xNcmRn"
}
GET /my-index/_search
{
  "query": {
    "query_string": {
      "query": "*华*",
      "fields": ["*"]
    }
  },
  "highlight": {
    "pre_tags": ["<span style='color:red'>"],
    "post_tags": ["</span>"],
    "fields": {"*": {}}
  }
}
# 查询：Term; Phrase; Match; Match Phrase; Multi Match; Query String; Simple Query String; Fuzzy; Prefix; Wildcard; Regexp; Range; Ids; Bool; Dis Max; Boosting; Constant Score; Function Score; Script Score; Sorting; Aggregation; ...
# 聚合Aggregations "aggs": Metric; Bucket; Pipeline; Matrix; Compound; Global; ...

# template settings mappings dynamic
PUT /_template/template_test
{
  "index_patterns": ["test*"],
  "order": 1,
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 1
  },
  "mappings": {
    "date_detection": false,
    "numeric_detection": true,
    "dynamic_templates": [
      {
        "strings_as_keywords": {
          "match_mapping_type": "string",
          "mapping": {
            "type": "keyword"
          }
        }
      },
      {
        "long_fields": {
          "match_mapping_type": "long",
          "mapping": {
            "type": "long"
          }
        }
      },
      {
        "double_fields": {
          "match_mapping_type": "double",
          "mapping": {
            "type": "double"
          }
        }
      }
    ]
  }
}
GET /_cat/templates?v
GET /_template/template_test
DELETE /_template/template_test














