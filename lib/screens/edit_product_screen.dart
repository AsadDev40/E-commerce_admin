import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myshop_admin/Model/product_model.dart';
import 'package:myshop_admin/provider/category_provider.dart';
import 'package:myshop_admin/provider/file_upload_provider.dart';
import 'package:myshop_admin/provider/image_picker_provider.dart';
import 'package:myshop_admin/provider/product_provider.dart';
import 'package:myshop_admin/provider/sale_provider.dart';
import 'package:myshop_admin/provider/video_picker_provider.dart';
import 'package:myshop_admin/screens/products_screen.dart';
import 'package:myshop_admin/utils/utils.dart';
import 'package:myshop_admin/widgets/constants.dart';
import 'package:myshop_admin/widgets/custom_dropdown.dart';
import 'package:myshop_admin/widgets/custom_text_fields.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController titleController;
  late TextEditingController marketpriceController;
  late TextEditingController colorController;
  late TextEditingController descriptionController;
  late TextEditingController discountedpriceController;

  VideoPlayerController? _videoController;

  bool _imagesUpdated = false;
  bool _videoUpdated = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.product.title);
    marketpriceController =
        TextEditingController(text: widget.product.originalPrice);
    colorController = TextEditingController(text: widget.product.color);
    descriptionController =
        TextEditingController(text: widget.product.description);
    discountedpriceController =
        TextEditingController(text: widget.product.discountprice);

    if (widget.product.productvideourl.isNotEmpty) {
      _initializeVideoController(widget.product.productvideourl);
    }
  }

  void _initializeVideoController(String videoUrl) {
    _videoController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    titleController.dispose();
    marketpriceController.dispose();
    colorController.dispose();
    descriptionController.dispose();
    discountedpriceController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImagePickerProvider>(context);
    final videoProvider = Provider.of<VideoPickerProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final fileuploadprovider = Provider.of<FileUploadProvider>(context);
    final saleProvider = Provider.of<SaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 14, right: 5, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 140,
                    width: 200,
                    child: CarouselSlider.builder(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: false,
                      ),
                      itemCount: widget.product.productImageUrls.length,
                      itemBuilder: (context, index, _) {
                        return GestureDetector(
                          onTap: () {
                            showBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20,
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Choose Product Photos',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () async {
                                            await imageProvider
                                                .pickImageFromCameraForProduct(
                                                    index);
                                            _imagesUpdated = true;
                                            Utils.back(context);
                                          },
                                          icon: const Icon(
                                            Icons.camera,
                                            color: Colors.purple,
                                          ),
                                          label: const Text(
                                            'Camera',
                                            style:
                                                TextStyle(color: Colors.purple),
                                          ),
                                        ),
                                        TextButton.icon(
                                          onPressed: () async {
                                            await imageProvider
                                                .pickImageFromGalleryForProduct(
                                                    index);
                                            _imagesUpdated = true;
                                            Utils.back(context);
                                          },
                                          icon: const Icon(
                                            Icons.image,
                                            color: Colors.purple,
                                          ),
                                          label: const Text(
                                            'Gallery',
                                            style:
                                                TextStyle(color: Colors.purple),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 140,
                            width: 145,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    widget.product.productImageUrls[index]),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color: Colors.purple,
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Choose Video',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton.icon(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      await videoProvider.pickVideoFromCamera();
                                      _videoUpdated = true;
                                      setState(() {
                                        _videoController = VideoPlayerController
                                            .file(videoProvider.selectedVideo!)
                                          ..initialize().then((_) {
                                            setState(() {});
                                          });
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.camera,
                                      color: Colors.purple,
                                    ),
                                    label: const Text(
                                      'Camera',
                                      style: TextStyle(color: Colors.purple),
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      await videoProvider
                                          .pickVideoFromGallery();
                                      _videoUpdated = true;
                                      setState(() {
                                        _videoController = VideoPlayerController
                                            .file(videoProvider.selectedVideo!)
                                          ..initialize().then((_) {
                                            setState(() {});
                                          });
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.video_collection_rounded,
                                      color: Colors.purple,
                                    ),
                                    label: const Text(
                                      'Gallery',
                                      style: TextStyle(color: Colors.purple),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 140,
                      width: 145,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      child: _videoController != null &&
                              _videoController!.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _videoController!.value.aspectRatio,
                              child: VideoPlayer(_videoController!),
                            )
                          : const Icon(
                              Icons.video_call,
                              color: Colors.purple,
                              size: 40,
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: const Text(
                        'Click to add photos',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.purple),
                      ),
                    ),
                    const SizedBox(width: 85),
                    const Text(
                      'Click to add videos',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.purple),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  CustomTextField(
                    controller: titleController,
                    hintText: 'Enter Product title:',
                    hintStyle:
                        const TextStyle(fontSize: 15, color: PrimaryColor),
                    textAlign: TextAlign.left,
                    enableBorder: true,
                    textStyle: const TextStyle(color: PrimaryColor),
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: marketpriceController,
                    hintText: 'Enter Market Price :',
                    hintStyle:
                        const TextStyle(fontSize: 15, color: PrimaryColor),
                    textAlign: TextAlign.left,
                    enableBorder: true,
                    textStyle: const TextStyle(color: PrimaryColor),
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: discountedpriceController,
                    hintText: 'Enter discounted Price :',
                    hintStyle:
                        const TextStyle(fontSize: 15, color: PrimaryColor),
                    textAlign: TextAlign.left,
                    enableBorder: true,
                    textStyle: const TextStyle(color: PrimaryColor),
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: colorController,
                    hintText: 'Enter Product Color :',
                    hintStyle:
                        const TextStyle(fontSize: 15, color: PrimaryColor),
                    textAlign: TextAlign.left,
                    enableBorder: true,
                    textStyle: const TextStyle(color: PrimaryColor),
                  ),
                  const SizedBox(height: 15),

                  // Sale Dropdown
                  Container(
                    padding: const EdgeInsets.only(right: 0),
                    height: 70,
                    width: 400,
                    child: CustomDropDown(
                      onChanged: (value) => saleProvider
                          .updateSelectedSale(value!), // Update Sale
                      value: saleProvider.selectedSale,
                      list: saleProvider.saleOptions,
                      expanded: true,
                      hintText: 'Select Sale',
                      textColor: Colors.purple,
                      borderColor: Colors.purple,
                      hintTextColor: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.only(right: 0),
                    height: 70,
                    width: 400,
                    child: CustomDropDown(
                      onChanged: (value) =>
                          categoryProvider.updateSelectedValue(value!),
                      value: categoryProvider.selectedValue,
                      list: categoryProvider.categoryNames,
                      expanded: true,
                      hintText: 'Select Category',
                      textColor: Colors.purple,
                      borderColor: Colors.purple,
                      hintTextColor: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: descriptionController,
                    hintText: 'Enter Description',
                    maxLines: 10,
                    hintStyle:
                        const TextStyle(fontSize: 15, color: PrimaryColor),
                    textAlign: TextAlign.left,
                    enableBorder: true,
                    textStyle: const TextStyle(color: PrimaryColor),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(130, 40)),
                      alignment: Alignment.center,
                    ),
                    onPressed: () async {
                      EasyLoading.show();

                      List<String> imageUrls = widget.product.productImageUrls;
                      String videoUrl = widget.product.productvideourl;

                      if (_imagesUpdated) {
                        List<File> selectedImages = imageProvider.selectedImages
                            .where((file) => file != null)
                            .cast<File>()
                            .toList();
                        imageUrls =
                            await fileuploadprovider.uploadMultipleFiles(
                          files: selectedImages,
                          folder: 'products/images',
                        );
                      }

                      if (_videoUpdated) {
                        videoUrl = await fileuploadprovider.fileUpload(
                              file: videoProvider.selectedVideo!,
                              fileName: 'product_video.mp4',
                              folder: 'products/videos',
                            ) ??
                            videoUrl;
                      }

                      ProductModel updatedProduct = ProductModel(
                        id: widget.product.id,
                        title: titleController.text,
                        category: categoryProvider.selectedValue.toString(),
                        description: descriptionController.text,
                        productImageUrls: imageUrls,
                        productvideourl: videoUrl,
                        discountprice: discountedpriceController.text,
                        originalPrice: marketpriceController.text,
                        rating: widget.product.rating,
                        color: colorController.text,
                        sale: saleProvider.selectedSale,
                      );

                      await productProvider.updateProduct(
                          widget.product.id, updatedProduct);

                      titleController.clear();
                      marketpriceController.clear();
                      discountedpriceController.clear();
                      colorController.clear();
                      imageProvider.reset();
                      descriptionController.clear();
                      videoProvider.reset();

                      EasyLoading.dismiss();
                      Utils.navigateTo(context, const ProductsScreen());
                    },
                    child: const Text(
                      'Update Product',
                      style: TextStyle(color: PrimaryColor),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
