function [matrix_ex_6_18_out_1,matrix_ex_6_18_out_2,matrix_ex_6_18_out_3,matrix_ex_6_18_out_4,matrix_ex_6_18_out_5,matrix_ex_6_18_out_6] = matrix_ex_6_18(matrix_ex_6_18_in_1,matrix_ex_6_18_in_2,matrix_ex_6_18_in_3,matrix_ex_6_18_in_4,matrix_ex_6_18_in_5,matrix_ex_6_18_in_6,matrix_ex_6_18_in_7,matrix_ex_6_18_in_8,matrix_ex_6_18_in_9,matrix_ex_6_18_in_10,matrix_ex_6_18_in_11,matrix_ex_6_18_in_12,matrix_ex_6_18_in_13,matrix_ex_6_18_in_14,matrix_ex_6_18_in_15,matrix_ex_6_18_in_16,matrix_ex_6_18_in_17,matrix_ex_6_18_in_18)
	persistent matrix_ex_6_18_in_2_reg_1 matrix_ex_6_18_in_3_reg_1 matrix_ex_6_18_in_5_reg_1 matrix_ex_6_18_in_8_reg_1 matrix_ex_6_18_in_9_reg_1 matrix_ex_6_18_in_11_reg_1 matrix_ex_6_18_in_14_reg_1 matrix_ex_6_18_in_14_reg_2 matrix_ex_6_18_in_15_reg_1 matrix_ex_6_18_in_16_reg_1 matrix_ex_6_18_in_17_reg_1 matrix_ex_6_18_in_18_reg_1;
	if (isempty(matrix_ex_6_18_in_2_reg_1))
		 matrix_ex_6_18_in_2_reg_1 = 0; matrix_ex_6_18_in_3_reg_1 = 0; matrix_ex_6_18_in_5_reg_1 = 0; matrix_ex_6_18_in_8_reg_1 = 0; matrix_ex_6_18_in_9_reg_1 = 0; matrix_ex_6_18_in_11_reg_1 = 0; matrix_ex_6_18_in_14_reg_1 = 0; matrix_ex_6_18_in_14_reg_2 = 0; matrix_ex_6_18_in_15_reg_1 = 0; matrix_ex_6_18_in_16_reg_1 = 0; matrix_ex_6_18_in_17_reg_1 = 0; matrix_ex_6_18_in_18_reg_1 = 0;
	end

	[matrix_ex_6_18_out_1_arg_1] = basic_buffer(matrix_ex_6_18_in_1);
	[matrix_ex_6_18_out_1_arg_2] = neg(matrix_ex_6_18_in_2_reg_1);
	[matrix_ex_6_18_out_1_arg_3] = neg(matrix_ex_6_18_in_3_reg_1);
	[matrix_ex_6_18_out_1_arg_4] = basic_buffer(matrix_ex_6_18_in_5_reg_1);
	[matrix_ex_6_18_out_1_arg_5] = basic_buffer(matrix_ex_6_18_in_14_reg_2);
	[matrix_ex_6_18_out_1_arg_6] = neg(matrix_ex_6_18_in_16_reg_1);
	[matrix_ex_6_18_out_1_arg_7] = neg(matrix_ex_6_18_in_17_reg_1);
	[matrix_ex_6_18_out_1_arg_8] = basic_buffer(matrix_ex_6_18_in_18_reg_1);
	[matrix_ex_6_18_out_2_arg_1] = neg(matrix_ex_6_18_in_1);
	[matrix_ex_6_18_out_2_arg_2] = neg(matrix_ex_6_18_in_2);
	[matrix_ex_6_18_out_2_arg_3] = basic_buffer(matrix_ex_6_18_in_3_reg_1);
	[matrix_ex_6_18_out_2_arg_4] = basic_buffer(matrix_ex_6_18_in_4);
	[matrix_ex_6_18_out_2_arg_5] = basic_buffer(matrix_ex_6_18_in_13);
	[matrix_ex_6_18_out_2_arg_6] = neg(matrix_ex_6_18_in_14_reg_1);
	[matrix_ex_6_18_out_2_arg_7] = neg(matrix_ex_6_18_in_15_reg_1);
	[matrix_ex_6_18_out_2_arg_8] = basic_buffer(matrix_ex_6_18_in_17_reg_1);
	[matrix_ex_6_18_out_3_arg_1] = basic_mul(matrix_ex_6_18_in_2,2);
	[matrix_ex_6_18_out_3_arg_2] = neg(matrix_ex_6_18_in_4);
	[matrix_ex_6_18_out_3_arg_3] = neg(matrix_ex_6_18_in_5);
	[matrix_ex_6_18_out_3_arg_4] = basic_buffer(matrix_ex_6_18_in_6);
	[matrix_ex_6_18_out_3_arg_5] = neg(matrix_ex_6_18_in_13);
	[matrix_ex_6_18_out_3_arg_6] = neg(matrix_ex_6_18_in_14);
	[matrix_ex_6_18_out_3_arg_7] = basic_buffer(matrix_ex_6_18_in_15_reg_1);
	[matrix_ex_6_18_out_3_arg_8] = basic_buffer(matrix_ex_6_18_in_16);
	[matrix_ex_6_18_out_4_arg_1] = neg(matrix_ex_6_18_in_1);
	[matrix_ex_6_18_out_4_arg_2] = basic_buffer(matrix_ex_6_18_in_2_reg_1);
	[matrix_ex_6_18_out_4_arg_3] = basic_buffer(matrix_ex_6_18_in_3_reg_1);
	[matrix_ex_6_18_out_4_arg_4] = neg(matrix_ex_6_18_in_5_reg_1);
	[matrix_ex_6_18_out_4_arg_5] = basic_buffer(matrix_ex_6_18_in_7);
	[matrix_ex_6_18_out_4_arg_6] = neg(matrix_ex_6_18_in_8_reg_1);
	[matrix_ex_6_18_out_4_arg_7] = neg(matrix_ex_6_18_in_9_reg_1);
	[matrix_ex_6_18_out_4_arg_8] = basic_buffer(matrix_ex_6_18_in_11_reg_1);
	[matrix_ex_6_18_out_4_arg_9] = neg(matrix_ex_6_18_in_13);
	[matrix_ex_6_18_out_4_arg_10] = basic_buffer(matrix_ex_6_18_in_14_reg_1);
	[matrix_ex_6_18_out_4_arg_11] = basic_buffer(matrix_ex_6_18_in_15_reg_1);
	[matrix_ex_6_18_out_4_arg_12] = neg(matrix_ex_6_18_in_17_reg_1);
	[matrix_ex_6_18_out_5_arg_1] = basic_buffer(matrix_ex_6_18_in_1);
	[matrix_ex_6_18_out_5_arg_2] = basic_buffer(matrix_ex_6_18_in_2);
	[matrix_ex_6_18_out_5_arg_3] = neg(matrix_ex_6_18_in_3_reg_1);
	[matrix_ex_6_18_out_5_arg_4] = neg(matrix_ex_6_18_in_4);
	[matrix_ex_6_18_out_5_arg_5] = neg(matrix_ex_6_18_in_7);
	[matrix_ex_6_18_out_5_arg_6] = neg(matrix_ex_6_18_in_8);
	[matrix_ex_6_18_out_5_arg_7] = basic_buffer(matrix_ex_6_18_in_9_reg_1);
	[matrix_ex_6_18_out_5_arg_8] = basic_buffer(matrix_ex_6_18_in_10);
	[matrix_ex_6_18_out_5_arg_9] = basic_buffer(matrix_ex_6_18_in_13);
	[matrix_ex_6_18_out_5_arg_10] = basic_buffer(matrix_ex_6_18_in_14);
	[matrix_ex_6_18_out_5_arg_11] = neg(matrix_ex_6_18_in_15_reg_1);
	[matrix_ex_6_18_out_5_arg_12] = neg(matrix_ex_6_18_in_16);
	[matrix_ex_6_18_out_6_arg_1] = basic_mul(matrix_ex_6_18_in_2,-2);
	[matrix_ex_6_18_out_6_arg_2] = basic_buffer(matrix_ex_6_18_in_4);
	[matrix_ex_6_18_out_6_arg_3] = basic_buffer(matrix_ex_6_18_in_5);
	[matrix_ex_6_18_out_6_arg_4] = neg(matrix_ex_6_18_in_6);
	[matrix_ex_6_18_out_6_arg_5] = basic_mul(matrix_ex_6_18_in_8,2);
	[matrix_ex_6_18_out_6_arg_6] = neg(matrix_ex_6_18_in_10);
	[matrix_ex_6_18_out_6_arg_7] = neg(matrix_ex_6_18_in_11);
	[matrix_ex_6_18_out_6_arg_8] = basic_buffer(matrix_ex_6_18_in_12);
	[matrix_ex_6_18_out_6_arg_9] = basic_mul(matrix_ex_6_18_in_14,-2);
	[matrix_ex_6_18_out_6_arg_10] = basic_buffer(matrix_ex_6_18_in_16);
	[matrix_ex_6_18_out_6_arg_11] = basic_buffer(matrix_ex_6_18_in_17);
	[matrix_ex_6_18_out_6_arg_12] = neg(matrix_ex_6_18_in_18);
	[matrix_ex_6_18_out_1_sum_1] = basic_add(matrix_ex_6_18_out_1_arg_1,matrix_ex_6_18_out_1_arg_2);
	[matrix_ex_6_18_out_2_sum_1] = basic_add(matrix_ex_6_18_out_2_arg_1,matrix_ex_6_18_out_2_arg_2);
	[matrix_ex_6_18_out_3_sum_1] = basic_add(matrix_ex_6_18_out_3_arg_1,matrix_ex_6_18_out_3_arg_2);
	[matrix_ex_6_18_out_4_sum_1] = basic_add(matrix_ex_6_18_out_4_arg_1,matrix_ex_6_18_out_4_arg_2);
	[matrix_ex_6_18_out_5_sum_1] = basic_add(matrix_ex_6_18_out_5_arg_1,matrix_ex_6_18_out_5_arg_2);
	[matrix_ex_6_18_out_6_sum_1] = basic_add(matrix_ex_6_18_out_6_arg_1,matrix_ex_6_18_out_6_arg_2);
	[matrix_ex_6_18_out_1_sum_2] = basic_add(matrix_ex_6_18_out_1_sum_1,matrix_ex_6_18_out_1_arg_3);
	[matrix_ex_6_18_out_2_sum_2] = basic_add(matrix_ex_6_18_out_2_sum_1,matrix_ex_6_18_out_2_arg_3);
	[matrix_ex_6_18_out_3_sum_2] = basic_add(matrix_ex_6_18_out_3_sum_1,matrix_ex_6_18_out_3_arg_3);
	[matrix_ex_6_18_out_4_sum_2] = basic_add(matrix_ex_6_18_out_4_sum_1,matrix_ex_6_18_out_4_arg_3);
	[matrix_ex_6_18_out_5_sum_2] = basic_add(matrix_ex_6_18_out_5_sum_1,matrix_ex_6_18_out_5_arg_3);
	[matrix_ex_6_18_out_6_sum_2] = basic_add(matrix_ex_6_18_out_6_sum_1,matrix_ex_6_18_out_6_arg_3);
	[matrix_ex_6_18_out_1_sum_3] = basic_add(matrix_ex_6_18_out_1_sum_2,matrix_ex_6_18_out_1_arg_4);
	[matrix_ex_6_18_out_2_sum_3] = basic_add(matrix_ex_6_18_out_2_sum_2,matrix_ex_6_18_out_2_arg_4);
	[matrix_ex_6_18_out_3_sum_3] = basic_add(matrix_ex_6_18_out_3_sum_2,matrix_ex_6_18_out_3_arg_4);
	[matrix_ex_6_18_out_4_sum_3] = basic_add(matrix_ex_6_18_out_4_sum_2,matrix_ex_6_18_out_4_arg_4);
	[matrix_ex_6_18_out_5_sum_3] = basic_add(matrix_ex_6_18_out_5_sum_2,matrix_ex_6_18_out_5_arg_4);
	[matrix_ex_6_18_out_6_sum_3] = basic_add(matrix_ex_6_18_out_6_sum_2,matrix_ex_6_18_out_6_arg_4);
	[matrix_ex_6_18_out_1_sum_4] = basic_add(matrix_ex_6_18_out_1_sum_3,matrix_ex_6_18_out_1_arg_5);
	[matrix_ex_6_18_out_2_sum_4] = basic_add(matrix_ex_6_18_out_2_sum_3,matrix_ex_6_18_out_2_arg_5);
	[matrix_ex_6_18_out_3_sum_4] = basic_add(matrix_ex_6_18_out_3_sum_3,matrix_ex_6_18_out_3_arg_5);
	[matrix_ex_6_18_out_4_sum_4] = basic_add(matrix_ex_6_18_out_4_sum_3,matrix_ex_6_18_out_4_arg_5);
	[matrix_ex_6_18_out_5_sum_4] = basic_add(matrix_ex_6_18_out_5_sum_3,matrix_ex_6_18_out_5_arg_5);
	[matrix_ex_6_18_out_6_sum_4] = basic_add(matrix_ex_6_18_out_6_sum_3,matrix_ex_6_18_out_6_arg_5);
	[matrix_ex_6_18_out_1_sum_5] = basic_add(matrix_ex_6_18_out_1_sum_4,matrix_ex_6_18_out_1_arg_6);
	[matrix_ex_6_18_out_2_sum_5] = basic_add(matrix_ex_6_18_out_2_sum_4,matrix_ex_6_18_out_2_arg_6);
	[matrix_ex_6_18_out_3_sum_5] = basic_add(matrix_ex_6_18_out_3_sum_4,matrix_ex_6_18_out_3_arg_6);
	[matrix_ex_6_18_out_4_sum_5] = basic_add(matrix_ex_6_18_out_4_sum_4,matrix_ex_6_18_out_4_arg_6);
	[matrix_ex_6_18_out_5_sum_5] = basic_add(matrix_ex_6_18_out_5_sum_4,matrix_ex_6_18_out_5_arg_6);
	[matrix_ex_6_18_out_6_sum_5] = basic_add(matrix_ex_6_18_out_6_sum_4,matrix_ex_6_18_out_6_arg_6);
	[matrix_ex_6_18_out_1_sum_6] = basic_add(matrix_ex_6_18_out_1_sum_5,matrix_ex_6_18_out_1_arg_7);
	[matrix_ex_6_18_out_2_sum_6] = basic_add(matrix_ex_6_18_out_2_sum_5,matrix_ex_6_18_out_2_arg_7);
	[matrix_ex_6_18_out_3_sum_6] = basic_add(matrix_ex_6_18_out_3_sum_5,matrix_ex_6_18_out_3_arg_7);
	[matrix_ex_6_18_out_4_sum_6] = basic_add(matrix_ex_6_18_out_4_sum_5,matrix_ex_6_18_out_4_arg_7);
	[matrix_ex_6_18_out_5_sum_6] = basic_add(matrix_ex_6_18_out_5_sum_5,matrix_ex_6_18_out_5_arg_7);
	[matrix_ex_6_18_out_6_sum_6] = basic_add(matrix_ex_6_18_out_6_sum_5,matrix_ex_6_18_out_6_arg_7);
	[matrix_ex_6_18_out_1_sum_7] = basic_add(matrix_ex_6_18_out_1_sum_6,matrix_ex_6_18_out_1_arg_8);
	[matrix_ex_6_18_out_2_sum_7] = basic_add(matrix_ex_6_18_out_2_sum_6,matrix_ex_6_18_out_2_arg_8);
	[matrix_ex_6_18_out_3_sum_7] = basic_add(matrix_ex_6_18_out_3_sum_6,matrix_ex_6_18_out_3_arg_8);
	[matrix_ex_6_18_out_4_sum_7] = basic_add(matrix_ex_6_18_out_4_sum_6,matrix_ex_6_18_out_4_arg_8);
	[matrix_ex_6_18_out_5_sum_7] = basic_add(matrix_ex_6_18_out_5_sum_6,matrix_ex_6_18_out_5_arg_8);
	[matrix_ex_6_18_out_6_sum_7] = basic_add(matrix_ex_6_18_out_6_sum_6,matrix_ex_6_18_out_6_arg_8);
	[matrix_ex_6_18_out_4_sum_8] = basic_add(matrix_ex_6_18_out_4_sum_7,matrix_ex_6_18_out_4_arg_9);
	[matrix_ex_6_18_out_5_sum_8] = basic_add(matrix_ex_6_18_out_5_sum_7,matrix_ex_6_18_out_5_arg_9);
	[matrix_ex_6_18_out_6_sum_8] = basic_add(matrix_ex_6_18_out_6_sum_7,matrix_ex_6_18_out_6_arg_9);
	[matrix_ex_6_18_out_4_sum_9] = basic_add(matrix_ex_6_18_out_4_sum_8,matrix_ex_6_18_out_4_arg_10);
	[matrix_ex_6_18_out_5_sum_9] = basic_add(matrix_ex_6_18_out_5_sum_8,matrix_ex_6_18_out_5_arg_10);
	[matrix_ex_6_18_out_6_sum_9] = basic_add(matrix_ex_6_18_out_6_sum_8,matrix_ex_6_18_out_6_arg_10);
	[matrix_ex_6_18_out_4_sum_10] = basic_add(matrix_ex_6_18_out_4_sum_9,matrix_ex_6_18_out_4_arg_11);
	[matrix_ex_6_18_out_5_sum_10] = basic_add(matrix_ex_6_18_out_5_sum_9,matrix_ex_6_18_out_5_arg_11);
	[matrix_ex_6_18_out_6_sum_10] = basic_add(matrix_ex_6_18_out_6_sum_9,matrix_ex_6_18_out_6_arg_11);
	[matrix_ex_6_18_out_4_sum_11] = basic_add(matrix_ex_6_18_out_4_sum_10,matrix_ex_6_18_out_4_arg_12);
	[matrix_ex_6_18_out_5_sum_11] = basic_add(matrix_ex_6_18_out_5_sum_10,matrix_ex_6_18_out_5_arg_12);
	[matrix_ex_6_18_out_6_sum_11] = basic_add(matrix_ex_6_18_out_6_sum_10,matrix_ex_6_18_out_6_arg_12);

	matrix_ex_6_18_out_1 = matrix_ex_6_18_out_1_sum_7;
	matrix_ex_6_18_out_2 = matrix_ex_6_18_out_2_sum_7;
	matrix_ex_6_18_out_3 = matrix_ex_6_18_out_3_sum_7;
	matrix_ex_6_18_out_4 = matrix_ex_6_18_out_4_sum_11;
	matrix_ex_6_18_out_5 = matrix_ex_6_18_out_5_sum_11;
	matrix_ex_6_18_out_6 = matrix_ex_6_18_out_6_sum_11;

	matrix_ex_6_18_in_2_reg_1 = matrix_ex_6_18_in_2;
	matrix_ex_6_18_in_3_reg_1 = matrix_ex_6_18_in_3;
	matrix_ex_6_18_in_5_reg_1 = matrix_ex_6_18_in_5;
	matrix_ex_6_18_in_8_reg_1 = matrix_ex_6_18_in_8;
	matrix_ex_6_18_in_9_reg_1 = matrix_ex_6_18_in_9;
	matrix_ex_6_18_in_11_reg_1 = matrix_ex_6_18_in_11;
	matrix_ex_6_18_in_14_reg_2 = matrix_ex_6_18_in_14_reg_1;
	matrix_ex_6_18_in_14_reg_1 = matrix_ex_6_18_in_14;
	matrix_ex_6_18_in_15_reg_1 = matrix_ex_6_18_in_15;
	matrix_ex_6_18_in_16_reg_1 = matrix_ex_6_18_in_16;
	matrix_ex_6_18_in_17_reg_1 = matrix_ex_6_18_in_17;
	matrix_ex_6_18_in_18_reg_1 = matrix_ex_6_18_in_18;
end