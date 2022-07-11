
import 'package:bloc_course/cubits/internet_cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocConsumer<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state == InternetState.lost) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Internet is not Connected...")));
        } else if (state == InternetState.gained) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Internet Connected..."),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Loading"),
            ),
          );
        }
      },
      builder: (context, state) {
        // == uses to check value
        // is uses to check datatype
        if (state == InternetState.lost) {
          return const Text("Internet is not Connected...");
        } else if (state == InternetState.gained) {
          return const Text("Internet Connected...");
        } else {
          return const Text("Loading...");
        }
      },
    )
        // child: BlocBuilder<InternetBloc, InternetState>(
        //   builder: (context, state) {
        //     // == uses to check value
        //     // is uses to check datatype
        //     if (state is InternetLostState) {
        //       return const Text("Please check Internet Connection...");
        //     } else if(state is InternetGainedState) {
        //       return const Text("Internet is working...");
        //     }else{
        //       return const Text("Loading...");
        //     }
        //   },
        // ),
        );
  }
}
