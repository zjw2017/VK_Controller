# Magisk模块在线更新模板

这是一个`适配 Magisk的versionCode大于等于24000`的模块在线更新(updateJson)**模板**

<div align="center">
<strong>
<samp>

[简体中文](README.md) · [English](README_English.md)(English暂未上线)

</samp>
</strong>
</div>

## **使用方法**

### **一、了解相关文件**

| 文件 | 类型 | 功能 |
| :--------:  | :-----:  | :----:  |
| .github/workflows/release.yml | 文件 | 工作流文件|
| module_files | 文件夹 | 存放您模块的相关文件 |
| module.json | 文件 | Magisk检测模块更新的依赖文件 |
| module.md | 文件 | Magisk模块检测到更新，点击<br>更新后，将会弹出d 更新日志 |

### **二、适配您的模块**

1. **复制文件**：将您的**模块文件夹**复制到**仓库根目录**，像案例中module_files文件夹一样。如果您有您的想法，请遵循您的想法
2. **修改[.github/workflows/release.yml](https://github.com/zjw2017/MagiskModule_OnlineUpdate/blob/main/.github/workflows/release.yml)**：根据**注释**修改相关代码

```yaml
# 本仓库的模块文件名为module_files，下文的url已写入相关文件，可供参考
# 下文所有"- name:"的后面的文案均为步骤名，可自行修改
    # release为工作流名，可自行修改
name: release
on:
  push:
    paths:
    # 可自行修改module.json的文件名，若修改，请将"module.json"字样全局替换掉，并同步修改根目录下module.json的文件名
      - "module.json"
  workflow_dispatch:
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: 1. 准备文件
        run: |
          echo "version=$(jq .version $GITHUB_WORKSPACE/module.json)" >> $GITHUB_ENV
          echo "versionCode=$(jq .versionCode $GITHUB_WORKSPACE/module.json)" >> $GITHUB_ENV
        # ModuleFolderName的变量值需要修改为您模块文件夹的名字
          echo "ModuleFolderName=module_files" >> $GITHUB_ENV
        # 此处可根据您的需求添加您需要的shell语句
      - name: 2. 制作模块
        run: |
          echo "version=${{ env.version }}" >>$GITHUB_WORKSPACE/${{ env.ModuleFolderName }}/module.prop
          echo "versionCode=${{ env.versionCode }}" >>$GITHUB_WORKSPACE/${{ env.ModuleFolderName }}/module.prop
          cd $GITHUB_WORKSPACE/${{ env.ModuleFolderName }}
          zip -q -r ${{ env.ModuleFolderName }}.zip *
          mv $GITHUB_WORKSPACE/${{ env.ModuleFolderName }}/${{ env.ModuleFolderName }}.zip $GITHUB_WORKSPACE/${{ env.ModuleFolderName }}.zip
      - name: 3. 创建GitHub Release
        id: create_release
        uses: actions/create-release@latest
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          tag_name: ${{ env.version }}
        # release_name后面的是Github Release的标题，可自行修改
        # 若涉及version和versionCode，请按照${{ env.version }}这个格式来写
          release_name: Your_Module_Name ${{ env.version }}
          draft: false
          prerelease: false
      - name: 4. 上传GitHub Release
        id: upload-release-asset
        uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: ./${{ env.ModuleFolderName }}.zip
          asset_name: ${{ env.ModuleFolderName }}.zip
          asset_content_type: application/zip
      - name: 5. 再次初始化仓库
        run: |
          rm -rf $GITHUB_WORKSPACE/*
      - uses: actions/checkout@v2
      - name: 6. 更新下载链接
        env:
          browser_download_url: ${{ steps.upload-release-asset.outputs.browser_download_url }}
        run: |
        # 请在引号内自行更新您的Github账号信息
          git config --global user.email "30484319+zjw2017@users.noreply.github.com"
        # 请在引号内自行更新您的Github账号信息
          git config --global user.name "柚稚的孩纸"
          sed -i '4d' $GITHUB_WORKSPACE/module.json
        # 作用是自动更新下载地址，因中国大陆地区问题，添加了代理头(https://ghproxy.com/)
        # 如您的地区可以访问Github相关网站，可以删掉代理头，如
        # sed -i '3a "zipUrl": "'"$browser_download_url"'",' $GITHUB_WORKSPACE/module.json
          sed -i '3a "zipUrl": "https://ghproxy.com/'"$browser_download_url"'",' $GITHUB_WORKSPACE/module.json
          jq . $GITHUB_WORKSPACE/module.json > $GITHUB_WORKSPACE/new.json
          rm -rf $GITHUB_WORKSPACE/module.json && mv $GITHUB_WORKSPACE/new.json $GITHUB_WORKSPACE/module.json
          git add ./module.json
        # 引号内为提交信息，可根据需要自行修改。若涉及version和versionCode，请按照${{ env.version }}这个格式来写
          git commit -m "v${{ env.version }}" -a
      - name: 7. 推送到Magisk Module仓库
        uses: ad-m/github-push-action@master
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          branch: ${{ github.ref }}
```

3. **修改[module.md](https://github.com/zjw2017/MagiskModule_OnlineUpdate/blob/main/module.md)**：文件名可**自定义修改**。模块的**更新日志**，语法为`Markdown`
4. **修改[module.json](https://github.com/zjw2017/MagiskModule_OnlineUpdate/blob/main/module.json)**：**文件名**需要**与`.github/workflows/release.yml`中第5行文件名一致**。我们需要修改第**2、3、5**行。

   变量：类型
   - version：string
   - versionCode：int
   - changelog：url
> 补充说明：url为`module.md`的[链接](https://github.com/zjw2017/MagiskModule_OnlineUpdate/blob/main/module.md)，只需要填写一次即可。如果是中国大陆地区，可在上一步中文件的链接前面加代理头（比如[https://ghproxy.com](https://ghproxy.com/)）。如您的地区可以访问Github相关网站，可以删掉代理头

5. **修改模块的`module.prop`以支持在线更新**：格式如下。参数顺序可以打乱，但
   
   **updateJson行**下面的**空行**务必**不能删除**

```text
id=<string>
name=<string>
author=<string>
description=<string>
updateJson=<url>

```

> 补充说明：url为`module.json`的[链接](https://github.com/zjw2017/MagiskModule_OnlineUpdate/blob/main/module.json)，只需要填写一次即可。如果是中国大陆地区，可在上一步中文件的链接前面加代理头（比如[https://ghproxy.com](https://ghproxy.com/)）。如您的地区可以访问Github相关网站，可以删掉代理头

6. 替换模块文件夹中的META-INF

> 原因是**支持在线更新的模块的META-INF会在刷入时被Magisk替换为默认的update-binary**，所以请**不要自定义/META-INF/com/google/android/update-binary文件**。若您**没有修改**过此文件，此步骤**可跳过**

7. 发起Action构建，完成发布


### 三、了解项目机制
本项目利用了**Github Actions**，设计了两种触发方式：**更新.json文件**和**手动触发**。

当您完成代码提交和模块迭代后，就要在 **.json文件** 中配置**版本号**来告知您的用户有新版本，同时，您可以在 **.md文件** 中使用`Markdown`语法书写此次的**更新日志**。不同于系统更新，日志不会叠加。所以您的用户只会看到最新版本的更新日志（除非您更新时保留上次的日志）。

到此，模块的迭代、版本号的更替、更新日志的书写都已经完成，接下来的一切交给**Github Actions**。

**Github Actions**做第一步就是读取 **.json文件** 中的**版本号**信息，将其输出到`module.prop`，这也是为什么前文的`module.prop`中为什么**updateJson行下面的空行不能删除**和**不需要书写版本号**的奥秘。第二步，将模块文件压缩为**zip格式**。第三步，将**模块文件上传**至**Github Release**。第四步，**更新.json文件**中的**下载地址**，并根据**预留的Github账户信息**将含有**新版本链接**的.json**文件**推送到**您的仓库**。

做完了这些，您的用户就可以在**Magisk**的**模块**选项卡中检测到新版本并安装到设备上。

但它也有一些劣势。工作流中上传**Github Release**的代码若遇到**相同名字的Tag**下**已存在Assets**时会报错**退出**，因此您不得不**手动删除刚才构建的Release**并**手动触发Action**来达到发行目的。但这么做依然会出现问题。因为先**上传Github Release**，后**更新下载链接**，工作流在**更新下载地址**时，若发现**两个版本的.json文件没有差异**时，也会报错**退出**，但此时**Release已经生成**，因此**即使报错**也**发行新版本**。

### 四、结语
欢迎大家用来适配自己的模块，同时也期待能有专业人员共同改进本项目，感谢大家！
