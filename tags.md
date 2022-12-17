---
layout: page
title: Tags
---
<ul class="tag-cloud">
{% assign sorted_tags = site.tags | sort %}
{% for tag in sorted_tags %}
  <li style="font-size: {{ tag | last | size | times: 4 | plus: 80  }}%">
    <a href="/tags/{{ tag | first }}">
      {{ tag | first }} ({{ tag | last | size }})
    </a>
  </li>
{% endfor %}
</ul>
