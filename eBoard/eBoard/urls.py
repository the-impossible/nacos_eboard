from django.contrib import admin
from django.conf.urls.static import static
from django.urls import path, include
from django.conf import settings


urlpatterns = [
    path("admin/", admin.site.urls),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

admin.site.site_title = "e-Notice Board"
admin.site.index_title = "e-Notice Board"
admin.site.site_header ="e-Notice Board"
